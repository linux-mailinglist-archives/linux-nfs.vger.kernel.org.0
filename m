Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962FC2DFEF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfE2OjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 10:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2OjA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 10:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1356180467;
        Wed, 29 May 2019 14:39:00 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-143.phx2.redhat.com [10.3.117.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7AB05D9E1;
        Wed, 29 May 2019 14:38:59 +0000 (UTC)
Subject: Re: [PATCH v3 07/11] Add a helper to return the real path given an
 export entry
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <341a5328-ae6e-755d-6351-8e764d429e61@RedHat.com>
Date:   Wed, 29 May 2019 10:38:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528203122.11401-8-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 May 2019 14:39:00 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Trond,

On 5/28/19 4:31 PM, Trond Myklebust wrote:
> Add a helper that can prepend the nfsd root directory path in order
> to allow mountd to perform its comparisons with mtab etc.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  support/export/export.c    | 24 ++++++++++++++++++++++++
>  support/include/exportfs.h |  1 +
>  support/include/nfslib.h   |  1 +
>  support/misc/nfsd_path.c   |  4 +++-
>  support/nfs/exports.c      |  4 ++++
>  5 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/support/export/export.c b/support/export/export.c
> index fbe68e84e5b3..82bbb54c5e9e 100644
> --- a/support/export/export.c
> +++ b/support/export/export.c
> @@ -20,6 +20,7 @@
>  #include "xmalloc.h"
>  #include "nfslib.h"
>  #include "exportfs.h"
> +#include "nfsd_path.h"
>  
>  exp_hash_table exportlist[MCL_MAXTYPES] = {{NULL, {{NULL,NULL}, }}, }; 
>  static int export_hash(char *);
> @@ -30,6 +31,28 @@ static void	export_add(nfs_export *exp);
>  static int	export_check(const nfs_export *exp, const struct addrinfo *ai,
>  				const char *path);
>  
> +/* Return a real path for the export. */
> +static void
> +exportent_mkrealpath(struct exportent *eep)
> +{
> +	const char *chroot = nfsd_path_nfsd_rootdir();
> +	char *ret = NULL;
> +
> +	if (chroot)
> +		ret = nfsd_path_prepend_dir(chroot, eep->e_path);
> +	if (!ret)
> +		ret = xstrdup(eep->e_path);
> +	eep->e_realpath = ret;
> +}
> +
> +char *
> +exportent_realpath(struct exportent *eep)
> +{
> +	if (!eep->e_realpath)
> +		exportent_mkrealpath(eep);
> +	return eep->e_realpath;
> +}
> +
>  void
>  exportent_release(struct exportent *eep)
>  {
> @@ -39,6 +62,7 @@ exportent_release(struct exportent *eep)
>  	free(eep->e_fslocdata);
>  	free(eep->e_uuid);
>  	xfree(eep->e_hostname);
> +	xfree(eep->e_realpath);
>  }
>  
>  static void
> diff --git a/support/include/exportfs.h b/support/include/exportfs.h
> index 4e0d9d132b4c..daa7e2a06d82 100644
> --- a/support/include/exportfs.h
> +++ b/support/include/exportfs.h
> @@ -171,5 +171,6 @@ struct export_features {
>  
>  struct export_features *get_export_features(void);
>  void fix_pseudoflavor_flags(struct exportent *ep);
> +char *exportent_realpath(struct exportent *eep);
>  
>  #endif /* EXPORTFS_H */
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index b09fce42e677..84d8270b330f 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -84,6 +84,7 @@ struct exportent {
>  	char *		e_uuid;
>  	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
>  	unsigned int	e_ttl;
> +	char *		e_realpath;
>  };
>  
>  struct rmtabent {
> diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> index 55bca9bdf4bd..8ddafd65ab76 100644
> --- a/support/misc/nfsd_path.c
> +++ b/support/misc/nfsd_path.c
> @@ -81,9 +81,11 @@ nfsd_path_prepend_dir(const char *dir, const char *pathname)
>  		dirlen--;
>  	if (!dirlen)
>  		return NULL;
> +	while (pathname[0] == '/')
> +		pathname++;
>  	len = dirlen + strlen(pathname) + 1;
>  	ret = xmalloc(len + 1);
> -	snprintf(ret, len, "%.*s/%s", (int)dirlen, dir, pathname);
> +	snprintf(ret, len+1, "%.*s/%s", (int)dirlen, dir, pathname);
>  	return ret;
>  }
>  
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 5f4cb9568814..3ecfde797e3b 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -155,6 +155,7 @@ getexportent(int fromkernel, int fromexports)
>  	}
>  
>  	xfree(ee.e_hostname);
> +	xfree(ee.e_realpath);
>  	ee = def_ee;
>  
>  	/* Check for default client */
> @@ -358,6 +359,7 @@ dupexportent(struct exportent *dst, struct exportent *src)
>  	if (src->e_uuid)
>  		dst->e_uuid = strdup(src->e_uuid);
>  	dst->e_hostname = NULL;
> +	dst->e_realpath = NULL;
>  }
>  
>  struct exportent *
> @@ -369,6 +371,8 @@ mkexportent(char *hname, char *path, char *options)
>  
>  	xfree(ee.e_hostname);
>  	ee.e_hostname = xstrdup(hname);
> +	xfree(ee.e_realpath);
> +	ee.e_realpath = NULL;
>  
>  	if (strlen(path) >= sizeof(ee.e_path)) {
>  		xlog(L_ERROR, "path name %s too long", path);
> 
I'm not really sure why this is happening on this patch and how
I missed this in the first version.. but I'm getting the following
linking error after applying this patch

/usr/bin/ld: ../../support/misc/libmisc.a(workqueue.o): in function `xthread_workqueue_worker':
/home/src/up/nfs-utils/support/misc/workqueue.c:133: undefined reference to `__pthread_register_cancel'
/usr/bin/ld: /home/src/up/nfs-utils/support/misc/workqueue.c:135: undefined reference to `__pthread_unregister_cancel'
/usr/bin/ld: ../../support/misc/libmisc.a(workqueue.o): in function `xthread_workqueue_alloc':
/home/src/up/nfs-utils/support/misc/workqueue.c:149: undefined reference to `pthread_create'
collect2: error: ld returned 1 exit status

To get things to link I need this patch

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index d54518b..590258a 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -54,7 +54,8 @@ rpc_pipefs_generator_SOURCES = $(COMMON_SRCS) rpc-pipefs-generator.c
 
 nfs_server_generator_LDADD = ../support/export/libexport.a \
 			     ../support/nfs/libnfs.la \
-			     ../support/misc/libmisc.a
+			     ../support/misc/libmisc.a \
+			     $(LIBPTHREAD)
 
 rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
 
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 4b29161..96524c7 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -10,6 +10,6 @@ exportfs_SOURCES = exportfs.c
 exportfs_LDADD = ../../support/export/libexport.a \
 	       	 ../../support/nfs/libnfs.la \
 		 ../../support/misc/libmisc.a \
-		 $(LIBWRAP) $(LIBNSL)
+		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
 
 MAINTAINERCLEANFILES = Makefile.in

I would think I should have seen this early when threads
was added to libmisc.a via the [Add a simple workqueue mechanism] 
patch but I didn't...

steved. 
