Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3E6F79B5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 01:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEDXXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDXXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 19:23:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127FA5FC
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 16:23:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F7D91F8AC;
        Thu,  4 May 2023 23:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683242602;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaneZCzLHe2XdnsH4lPL0wIwELwlgOzMooh7hxWageI=;
        b=nFv39AaOWGJB+VAT0td8TaJf5u2s3yKV3yV2w2QXDBN5lanGHnR2SkEPqquaP1wLrS+dkw
        j3hq2/NmP9SzTGN7djtJvExMt+UzgT8mlqnYPdRZXaP6Kv2r/c8h7Nep6E3dqQRUfxxQyN
        vk+VEIMC3PEH4+e6oguym6K9+WWInZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683242602;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaneZCzLHe2XdnsH4lPL0wIwELwlgOzMooh7hxWageI=;
        b=4MgubCgX+U5tflTf3Ar9RfjdX0PwGrbO5mNNcPzJCny4WmStXAbjMskfvxI+wLkhUUa5VV
        Y4T/rXNkVE3LoYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76369133F7;
        Thu,  4 May 2023 23:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CWyYGmo+VGTzaQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 23:23:22 +0000
Date:   Fri, 5 May 2023 01:23:21 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
Message-ID: <20230504232321.GA25208@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
 <ZFO6ywouPkmNKtkr@yuki>
 <20230504220037.GB4244@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504220037.GB4244@pevik>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

...
> Tomorrow I'll test this:

> check_umount()
> {
> 	local i
> 	local dir="$1"
> 	local type="${2:-lhost}"
> 	local cmd="grep -q $dir /proc/mounts"

> 	for i in $(seq 50); do
> 		if [ "$type" = "lhost" ]; then
> 			$cmd || return
> 		else
> 			tst_rhost_run -c "$cmd" || return
> 		fi
> 		tst_sleep 100ms
> 		tst_res TWARN "failed to umount '$dir'"
> 	done
> }

> 	for i in $VERSION; do
> 		local_dir="$(get_local_dir $i $n)"
> 		grep -q "$local_dir" /proc/mounts && umount $local_dir

> 		# instead of 'sleep 2' below check here:
> 		check_umount "$local_dir"

> 		n=$(( n + 1 ))
> 	done

> 	n=0
> 	for i in $VERSION; do
> 		type=$(get_socket_type $n)
> 		remote_dir="$(get_remote_dir $i $type)"

> 		if tst_net_use_netns; then
> 			if test -d $remote_dir; then
> 				exportfs -u *:$remote_dir
> 				check_umount "$remote_dir" # instead of sleep 1
> 				rm -rf $remote_dir
> 			fi
> 		else
> 			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
> 			check_umount "$remote_dir" rhost # instead of sleep 1
> 			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
> 		fi

> 		n=$(( n + 1 ))
> 	done

I tried various code (not only the one - wrong - above), but nothing works.
With fuser -vm, I wonder if there is some bug in older nfs versions:

                     USER        PID ACCESS COMMAND
/tmp/LTP_nfs08.fncaxJum2W/mntpoint/4/tcp:
                     root     kernel mount /tmp/LTP_nfs08.fncaxJum2W/mntpoint
                     root     kernel knfsd /tmp/LTP_nfs08.fncaxJum2W/mntpoint/4

Looking at c6c7f2a84da4 ("nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs
is unmounted"), maybe there are other bugs, which causes files are used.

I also tried to use /proc/fs/nfsd/unlock_filesystem and
/proc/fs/nfsd/write_unlock_ip which made things better a bit (6.2.12), but still
it's not 100% solution. Also, "Release all locks on a local file system"
(unlock_filesystem) and Release all locks used by a client (write_unlock_ip) are
unlikely what I'm searching.

		umount $local_dir
		echo "$local_dir" > /proc/fs/nfsd/unlock_filesystem
		# $(tst_ipaddr rhost) => IP of the server
		echo "$(tst_ipaddr rhost)" > /proc/fs/nfsd/write_unlock_ip
		...

		exportfs -u *:$remote_dir
		echo "$remote_dir" > /proc/fs/nfsd/unlock_filesystem

=> any hint is welcome.

Kind regards,
Petr
