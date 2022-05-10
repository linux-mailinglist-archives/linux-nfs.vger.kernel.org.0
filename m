Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24A521D6B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiEJPHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346013AbiEJPGo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 11:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6472983B4
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652193147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsE7opbzi6Do7DBOVvvjFVpc5H8rJ2JtvnPQc8qZbwg=;
        b=CViJIrmnVT7Mm73NZ78dceIHJ6TggBhCH4ZYVfwLmXHWesxDDXjAv/zVmE+LMqedk10qoF
        wKUQcfAZCqvSTLzjAW665oxQfVoZKY01vmKrfXonOia3PpFkB8DVecXX//4qxiS2pgSdP7
        r0+hYAFBqg2ztBqwXlLc8dBjlmNeMwc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-CdFfrxkrNoOZDvVzEa9DvA-1; Tue, 10 May 2022 10:32:26 -0400
X-MC-Unique: CdFfrxkrNoOZDvVzEa9DvA-1
Received: by mail-qt1-f198.google.com with SMTP id g1-20020ac85801000000b002f3b281f745so14612128qtg.22
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JsE7opbzi6Do7DBOVvvjFVpc5H8rJ2JtvnPQc8qZbwg=;
        b=iHEOTgBWsdAPheeNj6sIeSvWG+rw0pNHO+Vk0ZpVwi7rcR6aq05dOcI36XiT+VZV/1
         GdhqgahKzzmOZforKqmY06v9X40lVWO4djxdw2qRJ6c/tBRGJ3MAq7to8FGLJllarGSS
         2zFlQQDYhCRmPxj7Iu8P8HsStgeSAb63u1sGhhTF+59yLsn4/Kbt0wIRPJjDSY8kRX6t
         aOR75dvAgfFmDXQNBT3EDid9KEbIh82dscyYCpjfhL7Iw+TnpN/Um+ObtsOX+yu32uwJ
         JK3lI6WgUjFZtOLu2I+AQVamK8dchfyw8VsvPbEyM88lu98qZLWgMVQyz2JuPAXwIVe2
         VBjQ==
X-Gm-Message-State: AOAM531l/cf64BwXpVysWe0BpC/VcrLwz9c/URpLwClWB2DYDRJnQUJx
        6+axNDiLMoKbXxOrPuuOunCBbiy4eIh8dY0+cDxFm8P7gII3m00fzb683XeAGrcQcFSVeVccUTH
        2/+sgRFJskq98ewiYhWMj
X-Received: by 2002:a05:620a:470c:b0:6a0:256:9b10 with SMTP id bs12-20020a05620a470c00b006a002569b10mr16014698qkb.134.1652193144411;
        Tue, 10 May 2022 07:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAqwZcgWo421EEOm8ejzjzICSOYZYIHRhQRlDwipsi+xSKFry4cpNDcgC4NYp30LgagMIbKw==
X-Received: by 2002:a05:620a:470c:b0:6a0:256:9b10 with SMTP id bs12-20020a05620a470c00b006a002569b10mr16014661qkb.134.1652193144024;
        Tue, 10 May 2022 07:32:24 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84703000000b002f39b99f689sm9469526qtp.35.2022.05.10.07.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:32:23 -0700 (PDT)
Message-ID: <200443c8-c53a-a7ff-0876-aff144963267@redhat.com>
Date:   Tue, 10 May 2022 10:32:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] exports: Implement new export option reexport=
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-3-richard@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220502085045.13038-3-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

A compile error...

On 5/2/22 4:50 AM, Richard Weinberger wrote:
> When re-exporting a NFS volume it is mandatory to specify
> either a UUID or numerical fsid= option because nfsd is unable
> to derive a identifier on its own.
> 
> For NFS cross mounts this becomes a problem because nfsd also
> needs a identifier for every crossed mount.
> A common workaround is stating every single subvolume in the
> exports list too.
> But this defeats the purpose of the crossmnt option and is tedious.
> 
> This is where the reexport= tries to help.
> It offers various strategies to automatically derive a identifier
> for NFS volumes and sub volumes.
> Each have their pros and cons.
> 
> Currently two modes are implemented:
> 
> 1. auto-fsidnum
> 	In this mode mountd/exportd will create a new numerical fsid
> 	for a NFS volume and subvolume. The numbers are stored in a database
> 	such that the server will always use the same fsid.
> 	The entry in the exports file allowed to skip fsid= entiry but
> 	stating a UUID is allowed, if needed.
> 
> 	This mode has the obvious downside that load balancing is not
> 	possible since multiple re-exporting NFS servers would generate
> 	different ids.
> 
> 2. predefined-fsidnum
> 	This mode works just like auto-fsidnum but does not generate ids
> 	for you. It helps in the load balancing case. A system administrator
> 	has to manually maintain the database and install it on all re-exporting
> 	NFS servers. If you have a massive amount of subvolumes this mode
> 	will help because you don't have to bloat the exports list.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   support/export/Makefile.am  |  2 ++
>   support/include/nfslib.h    |  1 +
>   support/nfs/Makefile.am     |  1 +
>   support/nfs/exports.c       | 68 +++++++++++++++++++++++++++++++++++++
>   support/reexport/reexport.c | 65 +++++++++++++++++++++++++++++++++++
>   systemd/Makefile.am         |  4 +++
>   utils/exportfs/Makefile.am  |  6 ++++
>   utils/exportfs/exportfs.c   | 11 ++++++
>   utils/exportfs/exports.man  | 31 +++++++++++++++++
>   utils/mount/Makefile.am     |  7 ++++
>   10 files changed, 196 insertions(+)
> 
> diff --git a/support/export/Makefile.am b/support/export/Makefile.am
> index eec737f6..7338e1c7 100644
> --- a/support/export/Makefile.am
> +++ b/support/export/Makefile.am
> @@ -14,6 +14,8 @@ libexport_a_SOURCES = client.c export.c hostname.c \
>   		      xtab.c mount_clnt.c mount_xdr.c \
>   		      cache.c auth.c v4root.c fsloc.c \
>   		      v4clients.c
> +libexport_a_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
> +
>   BUILT_SOURCES 	= $(GENFILES)
>   
>   noinst_HEADERS = mount.h
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index 6faba71b..0465a1ff 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -85,6 +85,7 @@ struct exportent {
>   	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
>   	unsigned int	e_ttl;
>   	char *		e_realpath;
> +	int		e_reexport;
>   };
>   
>   struct rmtabent {
> diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
> index 67e3a8e1..2e1577cc 100644
> --- a/support/nfs/Makefile.am
> +++ b/support/nfs/Makefile.am
> @@ -9,6 +9,7 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
>   		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
>   		   svc_create.c atomicio.c strlcat.c strlcpy.c
>   libnfs_la_LIBADD = libnfsconf.la
> +libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
>   
>   libnfsconf_la_SOURCES = conffile.c xlog.c
>   
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 2c8f0752..bc2b1d93 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -31,6 +31,7 @@
>   #include "xlog.h"
>   #include "xio.h"
>   #include "pseudoflavors.h"
> +#include "reexport.h"
>   
>   #define EXPORT_DEFAULT_FLAGS	\
>     (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> @@ -103,6 +104,7 @@ static void init_exportent (struct exportent *ee, int fromkernel)
>   	ee->e_nsqgids = 0;
>   	ee->e_uuid = NULL;
>   	ee->e_ttl = default_ttl;
> +	ee->e_reexport = REEXP_NONE;
>   }
>   
>   struct exportent *
> @@ -302,6 +304,23 @@ putexportent(struct exportent *ep)
>   	}
>   	if (ep->e_uuid)
>   		fprintf(fp, "fsid=%s,", ep->e_uuid);
> +
> +	if (ep->e_reexport) {
> +		fprintf(fp, "reexport=");
> +		switch (ep->e_reexport) {
> +			case REEXP_AUTO_FSIDNUM:
> +				fprintf(fp, "auto-fsidnum");
> +				break;
> +			case REEXP_PREDEFINED_FSIDNUM:
> +				fprintf(fp, "predefined-fsidnum");
> +				break;
> +			default:
> +				xlog(L_ERROR, "unknown reexport method %i", ep->e_reexport);
> +				fprintf(fp, "none");
> +		}
> +		fprintf(fp, ",");
> +	}
> +
>   	if (ep->e_mountpoint)
>   		fprintf(fp, "mountpoint%s%s,",
>   			ep->e_mountpoint[0]?"=":"", ep->e_mountpoint);
> @@ -538,6 +557,7 @@ parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr)
>   	char 	*flname = efname?efname:"command line";
>   	int	flline = efp?efp->x_line:0;
>   	unsigned int active = 0;
> +	int saw_reexport = 0;
>   
>   	squids = ep->e_squids; nsquids = ep->e_nsquids;
>   	sqgids = ep->e_sqgids; nsqgids = ep->e_nsqgids;
> @@ -644,6 +664,13 @@ bad_option:
>   			}
>   		} else if (strncmp(opt, "fsid=", 5) == 0) {
>   			char *oe;
> +
> +			if (saw_reexport) {
> +				xlog(L_ERROR, "%s:%d: 'fsid=' has to be before 'reexport=' %s\n",
> +				     flname, flline, opt);
> +				goto bad_option;
> +			}
> +
>   			if (strcmp(opt+5, "root") == 0) {
>   				ep->e_fsid = 0;
>   				setflags(NFSEXP_FSID, active, ep);
> @@ -688,6 +715,47 @@ bad_option:
>   			active = parse_flavors(opt+4, ep);
>   			if (!active)
>   				goto bad_option;
> +		} else if (strncmp(opt, "reexport=", 9) == 0) {
> +#ifdef HAVE_REEXPORT_SUPPORT
> +			char *strategy = strchr(opt, '=');
> +
> +			if (!strategy) {
> +				xlog(L_ERROR, "%s:%d: bad option %s\n",
> +				     flname, flline, opt);
> +				goto bad_option;
> +			}
> +			strategy++;
> +
> +			if (saw_reexport) {
> +				xlog(L_ERROR, "%s:%d: only one 'reexport=' is allowed%s\n",
> +				     flname, flline, opt);
> +				goto bad_option;
> +			}
> +
> +			if (strcmp(strategy, "auto-fsidnum") == 0) {
> +				ep->e_reexport = REEXP_AUTO_FSIDNUM;
> +			} else if (strcmp(strategy, "predefined-fsidnum") == 0) {
> +				ep->e_reexport = REEXP_PREDEFINED_FSIDNUM;
> +			} else if (strcmp(strategy, "none") == 0) {
> +				ep->e_reexport = REEXP_NONE;
> +			} else {
> +				xlog(L_ERROR, "%s:%d: bad option %s\n",
> +				     flname, flline, strategy);
> +				goto bad_option;
> +			}
> +
> +			if (reexpdb_apply_reexport_settings(ep, flname, flline) != 0)
> +				goto bad_option;
> +
> +			if (ep->e_fsid)
> +				setflags(NFSEXP_FSID, active, ep);
> +
> +			saw_reexport = 1;
> +#else
> +			xlog(L_ERROR, "%s:%d: 'reexport=' not available, rebuild with --enable-reexport\n",
> +			     flname, flline);
> +			goto bad_option;
> +#endif
>   		} else {
>   			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>   					flname, flline, opt);
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 5474a21f..a9529b2b 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -283,3 +283,68 @@ void reexpdb_uncover_subvolume(uint32_t fsidnum)
>   
>   	free(path);
>   }
> +
> +/*
> + * reexpdb_apply_reexport_settings - Apply reexport specific settings to an exportent
> + *
> + * @ep: exportent to apply to
> + * @flname: Current export file, only useful for logging
> + * @flline: Current line, only useful for logging
> + *
> + * This is a helper function for applying reexport specific settings to an exportent.
> + * It searches a suitable fsid an sets @ep->e_fsid.
> + */
> +int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, int flline)
> +{
> +	uint32_t fsidnum;
> +	int found;
> +	int ret = 0;
> +
> +	if (ep->e_reexport == REEXP_NONE)
> +		goto out;
> +
> +	if (ep->e_uuid)
> +		goto out;
> +
> +	/*
> +	 * We do a lazy database init because we want to init the db only
> +	 * when at least one reexport= option is present.
> +	 */
> +	if (reexpdb_init() != 0) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	found = reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 0);
> +	if (!found) {
> +		if (ep->e_reexport == REEXP_AUTO_FSIDNUM) {
> +			found = reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 1);
> +			if (!found) {
> +				xlog(L_ERROR, "%s:%i: Unable to generate fsid for %s",
> +				     flname, flline, ep->e_path);
> +				ret = -1;
> +				goto out;
> +			}
> +		} else {
> +			if (!ep->e_fsid) {
> +				xlog(L_ERROR, "%s:%i: Selected 'reexport=' mode requires either a UUID 'fsid=' or a numerical 'fsid=' or a reexport db entry %d",
> +				     flname, flline, ep->e_fsid);
> +				ret = -1;
> +			}
> +
> +			goto out;
reexport.c: In function ‘reexpdb_apply_reexport_settings’:
reexport.c:335:25: error: label ‘out’ used but not defined
   335 |                         goto out;
       |                         ^~~~


> +		}
> +	}
> +
> +	if (ep->e_fsid) {
> +		if (ep->e_fsid != fsidnum) {
> +			xlog(L_ERROR, "%s:%i: Selected 'reexport=' mode requires configured numerical 'fsid=' to agree with reexport db entry",
> +			     flname, flline);
> +			ret = -1;
> +		}
> +	} else {
> +		ep->e_fsid = fsidnum;
> +	}
I'm assuming this is where the out needs to be

out:
> +	return ret;
> +}
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index e7f5d818..f254b218 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -69,6 +69,10 @@ nfs_server_generator_LDADD = ../support/export/libexport.a \
>   			     ../support/misc/libmisc.a \
>   			     $(LIBPTHREAD)
>   
> +if CONFIG_REEXPORT
> +nfs_server_generator_LDADD += ../support/reexport/libreexport.a $(LIBSQLITE) -lrt
> +endif
> +
>   rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
>   
>   if INSTALL_SYSTEMD
> diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
> index 96524c72..451637a0 100644
> --- a/utils/exportfs/Makefile.am
> +++ b/utils/exportfs/Makefile.am
> @@ -12,4 +12,10 @@ exportfs_LDADD = ../../support/export/libexport.a \
>   		 ../../support/misc/libmisc.a \
>   		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
>   
> +if CONFIG_REEXPORT
> +exportfs_LDADD += ../../support/reexport/libreexport.a $(LIBSQLITE) -lrt
> +endif
> +
> +exportfs_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
> +
>   MAINTAINERCLEANFILES = Makefile.in
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 6ba615d1..7f21edcf 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -38,6 +38,7 @@
>   #include "exportfs.h"
>   #include "xlog.h"
>   #include "conffile.h"
> +#include "reexport.h"
>   
>   static void	export_all(int verbose);
>   static void	exportfs(char *arg, char *options, int verbose);
> @@ -719,6 +720,16 @@ dump(int verbose, int export_format)
>   				c = dumpopt(c, "fsid=%d", ep->e_fsid);
>   			if (ep->e_uuid)
>   				c = dumpopt(c, "fsid=%s", ep->e_uuid);
> +			if (ep->e_reexport) {
> +				switch (ep->e_reexport) {
> +					case REEXP_AUTO_FSIDNUM:
> +						c = dumpopt(c, "reexport=%s", "auto-fsidnum");
> +						break;
> +					case REEXP_PREDEFINED_FSIDNUM:
> +						c = dumpopt(c, "reexport=%s", "predefined-fsidnum");
> +						break;
> +				}
> +			}
>   			if (ep->e_mountpoint)
>   				c = dumpopt(c, "mountpoint%s%s",
>   					    ep->e_mountpoint[0]?"=":"",
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 54b3f877..ad2c2c59 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -420,6 +420,37 @@ will only work if all clients use a consistent security policy.  Note
>   that early kernels did not support this export option, and instead
>   enabled security labels by default.
>   
> +.TP
> +.IR reexport= auto-fsidnum|predefined-fsidnum
> +This option helps when a NFS share is re-exported. Since the NFS server
> +needs a unique identifier for each exported filesystem and a NFS share
> +cannot provide such, usually a manual fsid is needed.
> +As soon
> +.IR crossmnt
> +is used manually assigning fsid won't work anymore. This is where this
> +option becomes handy. It will automatically assign a numerical fsid
> +to exported NFS shares. The fsid and path relations are stored in a SQLite
> +database. If
> +.IR auto-fsidnum
> +is selected, the fsid is also autmatically allocated.
> +.IR predefined-fsidnum
> +assumes pre-allocated fsid numbers and will just look them up.
> +This option depends also on the kernel, you will need at least kernel version
> +5.19.
> +Since
> +.IR reexport=
> +can automatically allocate and assign numerical fsids, it is no longer possible
> +to have numerical fsids in other exports as soon this option is used in at least
> +one export entry.
> +
> +The association between fsid numbers and paths is stored in a SQLite database.
> +Don't edit or remove the database unless you know exactly what you're doing.
> +.IR predefined-fsidnum
> +is useful when you have used
> +.IR auto-fsidnum
> +before and don't want further entries stored.
> +
> +
>   .SS User ID Mapping
>   .PP
>   .B nfsd
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 3101f7ab..0268488c 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -32,6 +32,13 @@ mount_nfs_LDADD = ../../support/nfs/libnfs.la \
>   		  ../../support/misc/libmisc.a \
>   		  $(LIBTIRPC)
>   
> +if CONFIG_REEXPORT
> +mount_nfs_LDADD += ../../support/reexport/libreexport.a \
> +		   ../../support/misc/libmisc.a \
> +		   $(LIBSQLITE) -lrt $(LIBPTHREAD)
> +endif
> +
> +
>   mount_nfs_SOURCES = $(mount_common)
>   
>   if CONFIG_LIBMOUNT

