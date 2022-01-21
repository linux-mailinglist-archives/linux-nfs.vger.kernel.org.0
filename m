Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2606E496688
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiAUUo7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 15:44:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42320 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAUUo7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 15:44:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 615BC1F37D;
        Fri, 21 Jan 2022 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642797897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UoJNm8/P0M9Dl+haSgiXy8MmyWzhrLLwFnIgMKkJcM=;
        b=qZxyY5O/GNcNhI8dN/FHi9je7s68xtPz67gvLD+EkDyFSVZw3qAAxE24NrqFZwzP+TY9ZH
        G4VM43rKx5uGupc8awVopzE6Mp4d302a2215qooKcm8S3BftxUG66vC1HZYGHo8ZIYMJJF
        IS7isDFUSYG/G2EJ+EqRIF8YfVd/TRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642797897;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UoJNm8/P0M9Dl+haSgiXy8MmyWzhrLLwFnIgMKkJcM=;
        b=N3QoIhx8U/xs1naDA+3LUpExA70xH1zSgJpMGmnUFQdGt6OG7onYGPKekD0eQlbTlibVhL
        HOqHLqr9taFFi8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6053313A98;
        Fri, 21 Jan 2022 20:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RxcAB0cb62G/AgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 21 Jan 2022 20:44:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     "Nikita Yushchenko" <nikita.yushchenko@virtuozzo.com>,
        ltp@lists.linux.it, kernel@openvz.org, linux-nfs@vger.kernel.org,
        "Steve Dickson" <SteveD@redhat.com>
Subject: Re: [PATCH] rpc_lib.sh: fix portmapper detection in case of socket activation
In-reply-to: <YenNsuS1gcA9tDe3@pevik>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>,
 <YenNsuS1gcA9tDe3@pevik>
Date:   Sat, 22 Jan 2022 07:44:51 +1100
Message-id: <164279789186.8775.7075880084961337149@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jan 2022, Petr Vorel wrote:
> Hi Nikita,
>=20
> [ Cc: Steve as user-space maintainer, also Neil and whole linux-nfs ]
>=20
> > On systemd-based linux hosts, rpcbind service is typically started via
> > socket activation, when the first client connects. If no client has
> > connected before LTP rpc test starts, rpcbind process will not be
> > running at the time of check_portmap_rpcbind() execution, causing
> > check_portmap_rpcbind() to report TCONF error.
>=20
> > Fix that by adding a quiet invocation of 'rpcinfo' before checking for
> > rpcbind.
>=20
> Looks reasonable, but I'd prefer to have confirmation from NFS experts.
>=20
> > For portmap, similar step is likely not needed, because portmap is used
> > only on old systemd and those don't use systemd.
>=20
> > Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> > ---
> >  testcases/network/rpc/basic_tests/rpc_lib.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
>=20
> > diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/net=
work/rpc/basic_tests/rpc_lib.sh
> > index c7c868709..e882e41b3 100644
> > --- a/testcases/network/rpc/basic_tests/rpc_lib.sh
> > +++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
> > @@ -8,6 +8,12 @@ check_portmap_rpcbind()
> >  	if pgrep portmap > /dev/null; then
> >  		PORTMAPPER=3D"portmap"
> >  	else
> > +		# In case of systemd socket activation, rpcbind could be
> > +		# not started until somebody tries to connect to it's socket.
> > +		#
> > +		# To handle that case properly, run a client now.
> > +		rpcinfo >/dev/null 2>&1

If it were me, I would remove the 'pgrep's and just call "rpcbind -p"
and make sure something responds.

NeilBrown



> nit: Shouldn't we keep stderr? In LTP we put required commands into
> $TST_NEEDS_CMDS. It'd be better not require rpcinfo (not a hard dependency),
> and thus it'd be better to see "command not found" when rpcinfo missing and=
 test
> fails.
>=20
> Kind regards,
> Petr
>=20
> > +
> >  		pgrep rpcbind > /dev/null && PORTMAPPER=3D"rpcbind" || \
> >  			tst_brk TCONF "portmap or rpcbind is not running"
> >  	fi
>=20
>=20
