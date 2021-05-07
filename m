Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA30376D32
	for <lists+linux-nfs@lfdr.de>; Sat,  8 May 2021 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhEGXPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 19:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhEGXPA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 May 2021 19:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FE4CB03B;
        Fri,  7 May 2021 23:13:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Steve Dickson" <steved@redhat.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: Re: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
In-reply-to: <A4E16B80-F754-4F11-9689-C2A4E5588019@oracle.com>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>,
 <A4E16B80-F754-4F11-9689-C2A4E5588019@oracle.com>
Date:   Sat, 08 May 2021 09:13:54 +1000
Message-id: <162042923420.12663.5218244822067233589@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 07 May 2021, Chuck Lever III wrote:
> 
> That's not really a UUID, as per RFC 4122. I'm guessing it's possible
> for a collision to occur pretty quickly, for instance. It would be nicer
> if a conformant UUID could be used here.

That sounds like a sensible approach.  I'll go and read RFC 4122 and see
what I can learn.

> 
> Is there a problem with specifying the export's fsid in /etc/exports?

Each ancestor directory of any export point needs to be exported with
the v4root flag, and those that are on tmpfs each need a unique uuid or
fsid.
Requiring that to be specified in /etc/exports is an extra burden to
impose on admin

So yes, I think it s a problem with requiring that specification.
(I'm not even sure if NFSEXP_V4ROOT exports can be specified in
/etc/exports, but that would be easy to fix of course.

Thanks,
NeilBrown


> 
> 
> > The patch borrows some code from exportfs.  Maybe that code should be
> > move to a library..
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > support/export/v4root.c | 57 +++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 57 insertions(+)
> > 
> > diff --git a/support/export/v4root.c b/support/export/v4root.c
> > index 3654bd7c10c0..fd36eb704441 100644
> > --- a/support/export/v4root.c
> > +++ b/support/export/v4root.c
> > @@ -11,6 +11,7 @@
> > #include <config.h>
> > #endif
> > 
> > +#include <fcntl.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <sys/queue.h>
> > @@ -21,6 +22,7 @@
> > #include <unistd.h>
> > #include <errno.h>
> > 
> > +#include "nfsd_path.h"
> > #include "xlog.h"
> > #include "exportfs.h"
> > #include "nfslib.h"
> > @@ -73,6 +75,38 @@ set_pseudofs_security(struct exportent *pseudo)
> > 	}
> > }
> > 
> > +static ssize_t exportfs_write(int fd, const char *buf, size_t len)
> > +{
> > +	return nfsd_path_write(fd, buf, len);
> > +}
> > +
> > +static int test_export(struct exportent *eep, int with_fsid)
> > +{
> > +	char *path = eep->e_path;
> > +	int flags = eep->e_flags | (with_fsid ? NFSEXP_FSID : 0);
> > +	/* beside max path, buf size should take protocol str into account */
> > +	char buf[NFS_MAXPATHLEN+1+64] = { 0 };
> > +	char *bp = buf;
> > +	int len = sizeof(buf);
> > +	int fd, n;
> > +
> > +	n = snprintf(buf, len, "-test-client- ");
> > +	bp += n;
> > +	len -= n;
> > +	qword_add(&bp, &len, path);
> > +	if (len < 1)
> > +		return 0;
> > +	snprintf(bp, len, " 3 %d 65534 65534 0\n", flags);
> > +	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
> > +	if (fd < 0)
> > +		return 0;
> > +	n = exportfs_write(fd, buf, strlen(buf));
> > +	close(fd);
> > +	if (n < 0)
> > +		return 0;
> > +	return 1;
> > +}
> > +
> > /*
> >  * Create a pseudo export
> >  */
> > @@ -82,6 +116,7 @@ v4root_create(char *path, nfs_export *export)
> > 	nfs_export *exp;
> > 	struct exportent eep;
> > 	struct exportent *curexp = &export->m_export;
> > +	char uuid[33];
> > 
> > 	dupexportent(&eep, &pseudo_root.m_export);
> > 	eep.e_ttl = default_ttl;
> > @@ -89,6 +124,28 @@ v4root_create(char *path, nfs_export *export)
> > 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
> > 	if (strcmp(path, "/") != 0)
> > 		eep.e_flags &= ~NFSEXP_FSID;
> > +	if (strcmp(path, "/") != 0 &&
> > +	    !test_export(&eep, 0)) {
> > +		/* Need a uuid - base it on path */
> > +		char buf[12], *pp = path;
> > +		unsigned int i = 0;
> > +
> > +		memset(buf, 0, sizeof(buf));
> > +		while (*pp) {
> > +			buf[i] ^= *pp++;
> > +			i += 1;
> > +			if (i >= sizeof(buf))
> > +				i = 0;
> > +		}
> > +		memset(uuid, 'F', 32);
> > +		uuid[32] = '\0';
> > +		pp = uuid + 32 - sizeof(buf) * 2;
> > +		for (i = 0; i < sizeof(buf); i++) {
> > +			snprintf(pp, 3, "%02X", buf[i]);
> > +			pp += 2;
> > +		}
> > +		eep.e_uuid = uuid;
> > +	}
> > 	set_pseudofs_security(&eep);
> > 	exp = export_create(&eep, 0);
> > 	if (exp == NULL)
> > -- 
> > 2.31.1
> > 
> 
> --
> Chuck Lever
> 
> 
> 
> 
