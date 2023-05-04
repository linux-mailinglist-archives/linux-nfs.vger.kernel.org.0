Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5F6F78B3
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEDWAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 18:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDWAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 18:00:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78941249F
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 15:00:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 987D822C6A;
        Thu,  4 May 2023 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683237640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z8k3zObH13DGCmCkCzS7+8pYZEXK5t6Avey+wIKjAw=;
        b=ZivXYlGJUghyiDoOQAt0AHOcIB8RztQhs+chAn62waGVN4242NZPvkGRLIX2RBZtRW9MP8
        x9Hd3MqRrymgvmPB6uFiu4JC7eZz6RalfU3kiqfe5U0+c6WaJRfgG/UnTLvww9YNFsCJMB
        tgOXMeUN/8Jm0Gye9CqKO0XEKNtI3hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683237640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z8k3zObH13DGCmCkCzS7+8pYZEXK5t6Avey+wIKjAw=;
        b=S05iTMO8VIhTo9P5f/rGHhkz7rx7OVsC6cDtVwdH+ji+pdEoFKnnb9EFCSB8ZoURSPQmpL
        hM1vuBs6B5ctRVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7A0E133F7;
        Thu,  4 May 2023 22:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PH29MAcrVGQjTAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 22:00:39 +0000
Date:   Fri, 5 May 2023 00:00:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
Message-ID: <20230504220037.GB4244@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
 <ZFO6ywouPkmNKtkr@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFO6ywouPkmNKtkr@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Hi!
> >  nfs_get_remote_path()
> > @@ -210,6 +213,7 @@ nfs_cleanup()
> >  		grep -q "$local_dir" /proc/mounts && umount $local_dir
> >  		n=$(( n + 1 ))
> >  	done
> > +	sleep 2

> >  	n=0
> >  	for i in $VERSION; do
> > @@ -219,12 +223,15 @@ nfs_cleanup()
> >  		if tst_net_use_netns; then
> >  			if test -d $remote_dir; then
> >  				exportfs -u *:$remote_dir
> > +				sleep 1
> >  				rm -rf $remote_dir
> >  			fi
> >  		else
> >  			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
> > +			sleep 1
> >  			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
> >  		fi
> > +
> >  		n=$(( n + 1 ))
> >  	done

> Generally I'm not happy about the sleeps in the code, the main problem
> is that the test still may fail in a case that something was slower than
> usuall and we decided to proceed after we slept for a pre-defined
> interval. Ideally these should be replaced with a active waiting, i.e.
> loop that checks some condition 10 times in a second or so. Hoewever I'm
> okay with getting this in so that we manage to have these tests in
> before the release and fixing it later on.

I wonder myself what is wrong and if there is a problem with my code (likely) or
with nfsd or with loop device (Christoph Hellwig has been changing
drivers/block/loop.c quite a lot).

Because if first umount is too early, it does not recover (i.e. tst_umount
contain 50 times trying to umount with 100ms, and that does not help).

I also wonder how should I detect it's ready to be umounted.
I'll have look if losetup "fuser -vm /dev/loop0" would help, but instead of
depending on the device, we'd probably want to look into /proc/mounts, right?
Tomorrow I'll test this:

check_umount()
{
	local i
	local dir="$1"
	local type="${2:-lhost}"
	local cmd="grep -q $dir /proc/mounts"

	for i in $(seq 50); do
		if [ "$type" = "lhost" ]; then
			$cmd || return
		else
			tst_rhost_run -c "$cmd" || return
		fi
		tst_sleep 100ms
		tst_res TWARN "failed to umount '$dir'"
	done
}

	for i in $VERSION; do
		local_dir="$(get_local_dir $i $n)"
		grep -q "$local_dir" /proc/mounts && umount $local_dir

		# instead of 'sleep 2' below check here:
		check_umount "$local_dir"

		n=$(( n + 1 ))
	done

	n=0
	for i in $VERSION; do
		type=$(get_socket_type $n)
		remote_dir="$(get_remote_dir $i $type)"

		if tst_net_use_netns; then
			if test -d $remote_dir; then
				exportfs -u *:$remote_dir
				check_umount "$remote_dir" # instead of sleep 1
				rm -rf $remote_dir
			fi
		else
			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
			check_umount "$remote_dir" rhost # instead of sleep 1
			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
		fi

		n=$(( n + 1 ))
	done

[1] https://gitlab.com/psmisc/psmisc/-/blob/master/src/fuser.c
