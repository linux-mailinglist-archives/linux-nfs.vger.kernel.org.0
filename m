Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB36106B19
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfKVKlR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 05:41:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:60100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbfKVKlQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A854B3F4;
        Fri, 22 Nov 2019 10:41:15 +0000 (UTC)
Date:   Fri, 22 Nov 2019 11:41:12 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFS: allow deprecation of NFS UDP protocol
Message-ID: <20191122104112.GB24235@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20191121160651.5317-1-olga.kornievskaia@gmail.com>
 <ce430173-8fc0-564a-eb51-f79698920436@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce430173-8fc0-564a-eb51-f79698920436@oracle.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga, Calum,

...
> > +config NFS_DISABLE_UDP_SUPPORT
> > +	bool "NFS: Disable NFS UDP protocol support"
> > +	depends on NFS_FS
> > +	default y
> > +	help
> > +	  Choose Y here to disable the use of NFS over UDP. NFS over UDP
> > +	  on modern networks (1Gb+) can lead to data corruption caused by
> > +	  fragmentation during high loads.
> > +	  The default is N because many deployments still use UDP.

> You've changed the default to 'y' for v2, but you've left in the 'N'
> comment.
+1

> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 02110a3..24ca314 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
> >   			to->to_maxval = to->to_initval;
> >   		to->to_exponential = 0;
> >   		break;
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >   	case XPRT_TRANSPORT_UDP:
> >   		if (retrans == NFS_UNSPEC_RETRANS)
> >   			to->to_retries = NFS_DEF_UDP_RETRANS;
> > @@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
> >   		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
> >   		to->to_exponential = 1;
> >   		break;
> > +#endif

> Should the first two of your added ifdefs be ifndefs?
+1

...

Other changes LGTM.

Kind regards,
Petr
