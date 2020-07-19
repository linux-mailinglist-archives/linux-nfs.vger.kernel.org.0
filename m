Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935AE2253D9
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jul 2020 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgGST5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Jul 2020 15:57:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgGST5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Jul 2020 15:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595188638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqLBfHn9hQsgYJ69NxWVJOwISrJRd5Y9kRmiqDtnz2o=;
        b=X7Xg/newos5vXLEaHznD8S2EOhjMIPjKTXhgXPpCvOyg1yRR6KH6v9r0KswkHgd9SA5Uxp
        Ombcxa5cVN4D3xMRcbQTgj6AzvqzFWLAmZyS7hMkwHuwEVCyWk8DkJf3xObMRgHLl8ADni
        Tyb+gVbSQASfetqbb/D/HopP6gTjQ7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-rcU9uODnPLC9t8Y470KHxQ-1; Sun, 19 Jul 2020 15:57:14 -0400
X-MC-Unique: rcU9uODnPLC9t8Y470KHxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBC0518A1DE9;
        Sun, 19 Jul 2020 19:57:13 +0000 (UTC)
Received: from ovpn-112-45.ams2.redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D107303C;
        Sun, 19 Jul 2020 19:57:12 +0000 (UTC)
Message-ID: <4dc8c372324d551456a47e60d73d926d96fc0d24.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] nfs-utils: Update nfs4_unique_id module
 parameter from the nfs.conf value
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Date:   Sun, 19 Jul 2020 20:57:11 +0100
In-Reply-To: <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
         <ff4f8d30e849190eeb2e0fee1ef501ee461a531f.camel@redhat.com>
         <F25A094C-CA96-45D3-8422-C2F77ECF9C78@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,
I must have missed the discussion on Trond's work sorry, and I agree
that having it fixed in a way that is both automatic and transparent to
the user is far preferable to the solution I have posted. Do we have
any timeline on this yet ?

My proposed solution would therefore be a stop-gap if required, as it
does not force any specific solution upon the system and merely adds a
few small features in order to assist the administrator if they choose
to make use of the existing kernel module option, in a way which would
preserve the idea of centralised configuration.

As an aside I was also going to propose the use of this same mechanism
to address the issue of the lockd options for port numbers, which as it
currently stands are manually set in both modprobe.d and in nfs.conf,
which as i understand it both must match for successful operation.  A
small addition to the scripts I have posted could see the modules.d
options automatically generated from the nfs.conf options, thus
reducing the scope for mistakes if the administrator chooses to alter
those values and further solidifying the idea of gathering all the
configuration in a single location.

Your thoughts as always are appreciated.

-Alice 

 
On Thu, 2020-07-16 at 10:02 -0400, Chuck Lever wrote:
> Hi Alice-
> 
> I agree that selecting a unique nfs4_client_id string is a problem.
> 
> However, I thought that Trond is working on a udev-based mechanism
> for automatically choosing one that uniquifies containers as well
> as stand-alone clients.
> 
> I'd prefer if we stuck with one mechanism for doing this rather than
> having both.
> 
> Is there rationale for having this in nfs.conf instead of being
> completely opaque to the administrator? I don't see a compelling
> need for an administrator to adjust this if it is truly a random
> string of bytes. Do you know of one?
> 
> 
> > On Jul 16, 2020, at 9:56 AM, Alice Mitchell <ajmitchell@redhat.com>
> > wrote:
> > 
> > This reintroduces the nfs-config.service in order to ensure
> > that values are taken from nfs.conf and fed to the kernel
> > module if it is loaded and modprobe.d config incase it is not
> > 
> > Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
> > ---
> > nfs.conf                      |  1 +
> > systemd/Makefile.am           |  3 +++
> > systemd/README                |  5 +++++
> > systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
> > systemd/nfs-config.service.in | 17 +++++++++++++++++
> > systemd/nfs.conf.man          | 12 +++++++++++-
> > 6 files changed, 65 insertions(+), 1 deletion(-)
> > create mode 100755 systemd/nfs-conf-export.sh
> > create mode 100644 systemd/nfs-config.service.in
> > 
> > diff --git a/nfs.conf b/nfs.conf
> > index 186a5b19..8bb41227 100644
> > --- a/nfs.conf
> > +++ b/nfs.conf
> > @@ -4,6 +4,7 @@
> > #
> > [general]
> > # pipefs-directory=/var/lib/nfs/rpc_pipefs
> > +# nfs4_unique_id = ${machine-id}
> > #
> > [exports]
> > # rootdir=/export
> > diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> > index 75cdd9f5..51acdc3f 100644
> > --- a/systemd/Makefile.am
> > +++ b/systemd/Makefile.am
> > @@ -9,6 +9,7 @@ unit_files =  \
> >     nfs-mountd.service \
> >     nfs-server.service \
> >     nfs-utils.service \
> > +    nfs-config.service \
> >     rpc-statd-notify.service \
> >     rpc-statd.service \
> >     \
> > @@ -69,4 +70,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-
> > pipefs-generator
> > install-data-hook: $(unit_files)
> > 	mkdir -p $(DESTDIR)/$(unitdir)
> > 	cp $(unit_files) $(DESTDIR)/$(unitdir)
> > +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
> > +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
> > endif
> > diff --git a/systemd/README b/systemd/README
> > index da23d6f6..56108b10 100644
> > --- a/systemd/README
> > +++ b/systemd/README
> > @@ -28,6 +28,11 @@ by a suitable 'preset' setting:
> >     If enabled, then blkmapd will be run when nfs-client.target is
> >     started.
> > 
> > + nfs-config.service
> > +    Invoked by nfs-client.target to export values from nfs.conf to
> > +    any kernel modules that require it, such as setting
> > nfs4_unique_id
> > +    for the nfs client modules
> > +
> > Another special unit is "nfs-utils.service".  This doesn't really
> > do
> > anything, but exists so that other units may declare themselves as
> > "PartOf" nfs-utils.service.
> > diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-
> > export.sh
> > new file mode 100755
> > index 00000000..486e8df9
> > --- /dev/null
> > +++ b/systemd/nfs-conf-export.sh
> > @@ -0,0 +1,28 @@
> > +#!/bin/bash
> > +#
> > +# This script pulls values out of /etc/nfs.conf and configures
> > +# the appropriate kernel modules which cannot read it directly
> > +
> > +NFSMOD=/sys/module/nfs/parameters/nfs4_unique_id
> > +NFSPROBE=/etc/modprobe.d/nfs.conf
> > +
> > +# Now read the values from nfs.conf
> > +MACHINEID=`nfsconf --get general nfs4_unique_id`
> > +if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
> > +then
> > +# No config vaue found, assume blank
> > +MACHINEID=""
> > +fi
> > +
> > +# Kernel module is already loaded, update the live one
> > +if [ -e $NFSMOD ]; then
> > +echo -n "$MACHINEID" >> $NFSMOD
> > +fi
> > +
> > +# Rewrite the modprobe file for next reboot
> > +echo "# This file is overwritten by systemd nfs-config.service" >
> > $NFSPROBE
> > +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
> > +echo "# Do not hand modify" >> $NFSPROBE
> > +echo "options nfs nfs4_unique_id=\"$MACHINEID\"" >> $NFSPROBE
> > +
> > +echo "Set to: $MACHINEID"
> > diff --git a/systemd/nfs-config.service.in b/systemd/nfs-
> > config.service.in
> > new file mode 100644
> > index 00000000..c5ef1024
> > --- /dev/null
> > +++ b/systemd/nfs-config.service.in
> > @@ -0,0 +1,17 @@
> > +[Unit]
> > +Description=Preprocess NFS configuration
> > +PartOf=nfs-client.target
> > +After=nfs-client.target
> > +DefaultDependencies=no
> > +
> > +[Service]
> > +Type=oneshot
> > +# This service needs to run any time any nfs service
> > +# is started, so changes to local config files get
> > +# incorporated.  Having "RemainAfterExit=no" (the default)
> > +# ensures this happens.
> > +RemainAfterExit=no
> > +ExecStart=@_libexecdir@/nfs-utils/nfs-conf-export.sh
> > +
> > +[Install]
> > +WantedBy=nfs-client.target
> > diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> > index 28dbaa99..fb9d2dab 100644
> > --- a/systemd/nfs.conf.man
> > +++ b/systemd/nfs.conf.man
> > @@ -101,8 +101,11 @@ When a list is given, the members should be
> > comma-separated.
> > .TP
> > .B general
> > Recognized values:
> > -.BR pipefs-directory .
> > +.BR pipefs-directory ,
> > +.BR nfs4_unique_id .
> > 
> > +For 
> > +.BR pipefs-directory
> > See
> > .BR blkmapd (8),
> > .BR rpc.idmapd (8),
> > @@ -110,6 +113,13 @@ and
> > .BR rpc.gssd (8)
> > for details.
> > 
> > +The
> > +.BR nfs4_unique_id
> > +value is used by the NFS4 client when identifying itself to
> > servers and
> > +can be used to ensure that this value is unique when the local
> > system name
> > +perhaps is not. For full details please refer to the kernel
> > Documentation
> > +.I filesystems/nfs/nfs.txt
> > +
> > .TP
> > .B exports
> > Recognized values:
> > -- 
> > 2.18.1
> > 
> > 
> 
> --
> Chuck Lever
> 
> 
> 

