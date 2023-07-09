Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8A74C176
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGIHjL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGIHjL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 03:39:11 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8CE46
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kzb5wH6hzmoNMcGu96wPxMOAg+k0Kw4cr/OkjmSKGW4=; b=GZP9P75/O04zCFq9gFekYS2YBi
        JVJIlbPBczPj2++Sz0VNYRnXYsA7w8bG7xvEgJJkvNr3k4nFiyh2vXI1oCMBR6z9CLlxOKelhCF0K
        5NdsCi77TZ/PTMQ4grd9cjkFH1/zz/69OXrXJ+7qc7/PI55V/buUr3odPJRc7ETL/zMiZUqUL2SQW
        +ggtNg3z8i0DWf/KVopBJhYQGfJBdiyrBVdRqYAOjb7Memm+1pgDM40MioaZrXpFA2xZabOUEaWsj
        PmDDlwikbYdTTjwkMtCONm8DazDlaiSxOEvPAb8jBk82Bg0oUuygstr//2xcubp6ZY3lUKzKX5LSd
        YMdtJXTw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1qIP0Q-00EjO4-BS; Sun, 09 Jul 2023 07:38:55 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id AB317BE2DE0; Sun,  9 Jul 2023 09:38:52 +0200 (CEST)
Date:   Sun, 9 Jul 2023 09:38:52 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Andreas Hasenack <andreas@canonical.com>,
        Steve Dickson <steved@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ben Hutchings <benh@debian.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: Always run rpc-pipefs-generator generator (was: Re: Why keep
 var-lib-nfs-rpc_pipefs.mount around?)
Message-ID: <ZKpkDG2kTWVFSNiZ@eldamar.lan>
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
 <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com>
 <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
 <CANYNYEEA1CHwvZhrr2W0-BcGR1Rm50QSTdHwb0pygz4z0ZY=uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pCSCpq8lMj19RtxP"
Content-Disposition: inline
In-Reply-To: <CANYNYEEA1CHwvZhrr2W0-BcGR1Rm50QSTdHwb0pygz4z0ZY=uQ@mail.gmail.com>
X-Debian-User: carnil
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--pCSCpq8lMj19RtxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steve, 

On Mon, Jul 25, 2022 at 09:38:40AM -0300, Andreas Hasenack wrote:
> Hi,
> 
> On Sat, Jul 23, 2022 at 2:29 PM Steve Dickson <steved@redhat.com> wrote:
> >
> > My apologies delayed response... extended PTO
> >
> > On 7/11/22 9:13 AM, Benjamin Coddington wrote:
> > > On 8 Jul 2022, at 12:50, Andreas Hasenack wrote:
> > >
> > >> Hi,
> > >>
> > >> I was tracking down a Debian/Ubuntu bug with nfs-utils 2.6.1 where in
> > >> one case, after installing the packages, you would end up with
> > >> rpc_pipefs mounted at the same time in two locations: /run/rpc_pipefs
> > >> and /var/lib/nfs/rpc_pipefs. The /run location is what debian/ubuntu
> > >> default to.
> > >>
> > >> After poking around a bit, I think I found out why that is
> > >> happening[1], but it led me to ask this question: why is
> > >> var-lib-nfs-rpc_pipefs.mount (and its corresponding rpc_pipefs.target
> > >> unit) still shipped, given that nfs-utils now has a generator?
> > >
> > > Could just be an oversight, or perhaps a better reason exists.  The
> > > nfs-utils userspace has to handle a lot of different cases and legacy
> > > setups.
> > >
> > > Steve D, do you know?
> > Its not clear to me, if the read from nfs.conf does not
> > happen how changing the rpc_pipefs directory could happen.
> 
> The read happens, it's just that in that particular bug scenario, the
> /etc/nfs.conf file isn't there yet.
> 
> In the debian case, two things are triggering this bug[1]:
> - the /etc/nfs.conf file is not shipped by the package in that
> location. Instead, it's put in place by the postinst script (like
> rpm's %postinst)[2].
> - autofs recommends[3], not depends, nfs-common. This means that
> autofs can be setup before nfs-common is, and if that happens,
> /etc/nfs.conf doesn't exist yet. But the nfs-common systemd unit files
> do exist, and the generator is run when autofs calls systemctl
> daemon-reload in its postinst. Since there is no /etc/nfs.conf, the
> generator exits silently.
> 
> > When the read from nfs.conf happens and the rpc_pipefs directory
> > is not defined, the compiled in default rpc_pipefs directory
> 
> Or if /etc/nfs.conf isn't there, the generator exits silently.
> 
> > will be used and the generator will exit and not
> > generating the systemd files (using the installed ones).
> >
> > If the rpc_pipefs directory is defined in nfs.conf, the
> > generator will set up that directory as the
> > rpc_pipefs directory and systemd files will be
> > generated.
> >
> > So by taking out the nfs.conf read, the only way to change
> > the default rpc_pipefs directory is to recompile nfs-utils.
> 
> Actually, I'm doing two things:
> - taking out the var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target units
> - taking out the bit from the generator that compares the configured
> pipefs directory with the compile-time default:
> --- a/systemd/rpc-pipefs-generator.c
> +++ b/systemd/rpc-pipefs-generator.c
> @@ -139,9 +139,6 @@ int main(int argc, char *argv[])
>      s = conf_get_str("general", "pipefs-directory");
>      if (!s)
>          exit(0);
> -    if (strlen(s) == strlen(RPC_PIPEFS_DEFAULT) &&
> -            strcmp(s, RPC_PIPEFS_DEFAULT) == 0)
> -        exit(0);
> 
>      if (is_non_pipefs_mountpoint(s))
>          exit(1);
> 
> Therefore I'm fully relying on the generator all the time, whatever
> the pipefs directory is. And my question is wouldn't this be a sane
> default behavior for all users of nfs-utils, instead of having the
> extra complication of having two units for each of rpc_pipefs mount
> and target? Did I miss something?
> 
> Unfortunately I haven't heard back yet from the debian maintainer
> about this.[4] Maybe there is a "debian packaging" way to fix this. I
> also thought about systemd conditionals on /etc/nfs.conf, but then I
> would probably have to add them to a bunch of units (all of them?).
> 
> 1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1014429
> 2. https://salsa.debian.org/kernel-team/nfs-utils/-/blob/master/debian/nfs-common.postinst#L9
> 3. https://salsa.debian.org/debian/autofs/-/blob/master/debian/control#L35
> 4. https://salsa.debian.org/kernel-team/nfs-utils/-/merge_requests/18

FWIW, in Debian we have applied the respective change. The idea would
be to only depend on a single mechanism for setting up the mounts
rather than a combination of the two (the generator and the static
mount unit). For this reason we have applied the attached patch, and
are not installing the units that we will let the generator produce,
that is var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target

We in Debian for long have diverged too much from you upstream,
causing that we lacked behind several new upstream version and stuck
with old versions in stable releases. We want to avoid running into
that again in future. So if this make sense to you, would you apply
the same (or as you prefer similar) change to you upstream?

On one side so you could apply Andreas Hasenack patch, secondly
installing the var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target
could be dropped (note no changes to the other units needed as the
repsective needed dependencies are generated by the systemd
generator).

Ben, Andreas, please add what else is needed from your point of view
please!

Thanks a lot for considering this. If you have any suggestion further
how we can unify the Debian downstream to you upstream, let us know
please.

Regards,
Salvatore

--pCSCpq8lMj19RtxP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="always-run-generator.patch"

Description: Always run the generator
 Run the generator even if the pipefs-directory setting is the default one.
Author: Andreas Hasenack <andreas@canonical.com>
Bug-Ubuntu: https://bugs.launchpad.net/bugs/1971935
Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1014429
Forwarded: https://lore.kernel.org/linux-nfs/EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com/
Last-Update: 2022-07-12
---
This patch header follows DEP-3: http://dep.debian.net/deps/dep3/
diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index c24db567..7c42431f 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -139,9 +139,6 @@ int main(int argc, char *argv[])
 	s = conf_get_str("general", "pipefs-directory");
 	if (!s)
 		exit(0);
-	if (strlen(s) == strlen(RPC_PIPEFS_DEFAULT) &&
-			strcmp(s, RPC_PIPEFS_DEFAULT) == 0)
-		exit(0);
 
 	if (is_non_pipefs_mountpoint(s))
 		exit(1);

--pCSCpq8lMj19RtxP--
