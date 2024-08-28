Return-Path: <linux-nfs+bounces-5863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A05962998
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679D32865CB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7B1891AA;
	Wed, 28 Aug 2024 14:01:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7A17A922
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853709; cv=none; b=L7afYB6HDh8W0+gqW8pbz30KN+KEIjX92zEHIm+2zbqkryKi5WdWDQ5T5H+idhxEf+Hhqxn4bv/L+eCk8D5pvlhMJBtmlWyCgZlZpsiuhJGn8OqKhRwWr4RRaIMy0nEXNKli/ZT/S8ACOl7RunM7WBSXqTxkuJrzYneBFBogCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853709; c=relaxed/simple;
	bh=ZjG8yFQBGrd5+egMm4aHBVToLoIg8Xesgrm6X5HArzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuyE+S7S8+OKjAfolMKelTDm7G5S1NUiMlYvDI5w732KGXZxpb6YBq2UsA76IHl3CajHejjNkf48ejO4t8naBSLpMjs5lwlD61TaRmCPMPw5Uxcn8m2+2OhewvEUvLUySsVUV+keqvflrxe0e+NfHS6hAdxHBBEeBKj2HezZnjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3279421B80;
	Wed, 28 Aug 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 045821398F;
	Wed, 28 Aug 2024 14:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P/e6M8ctz2YrMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 14:01:43 +0000
Date: Wed, 28 Aug 2024 16:01:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsstat01: Read client stats from netns rhost
Message-ID: <20240828140141.GA1716031@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240828132325.23111-1-mdoucha@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828132325.23111-1-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 3279421B80
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi Martin,

Thanks for fixing the test.

> On newer kernels, network namespaces have separate NFS stats. Detect
> support for per-NS files and read stats from the correct NS.

I'll mention before merging that it was kernel 6.9 and it got backported to up
to 5.15 so far.


Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> The /proc/net/rpc/nfs file did not exist in nested network namespaces
> on older kernels. The per-NS stats patchset adds it so we need to check
> for its presence to read the correct stats on kernels where it was
> backported.

> Kernel devs have also asked for a test that'll ensure the patchset doesn't
> get accidentaly reverted. Since this test uses namespaces only when
> the server and client run on the same machine, it'll be better to create
> a separate test for that. I'll send it later.
Thanks!

Kind regards,
Petr

>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 24 +++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index c2856eff1..8d7202cf3 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -3,8 +3,19 @@
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001

> +TST_SETUP="nfsstat_setup"
>  TST_TESTFUNC="do_test"
>  TST_NEEDS_CMDS="nfsstat"
> +NS_STAT_RHOST=0
> +
> +nfsstat_setup()
> +{
> +	nfs_setup
> +
> +	if tst_net_use_netns && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
> +		tst_rhost_run -c "test -r /proc/net/rpc/nfs" && NS_STAT_RHOST=1
> +	fi
> +}

>  get_calls()
>  {
> @@ -15,15 +26,22 @@ get_calls()
>  	local calls opt

>  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> +	[ "$nfs_f" = "nfsd" ] && opt="-s$opt" || opt="-c$opt"
> +
> +	if tst_net_use_netns; then
> +		# In netns setup, rhost is the client
> +		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
> +	else
> +		[ "$nfs_f" != "nfs" ] && type="rhost"
> +	fi

>  	if [ "$type" = "lhost" ]; then
>  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> -		ROD nfsstat -c$opt | grep -q "$calls"
> +		ROD nfsstat $opt | grep -q "$calls"
>  	else
>  		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
>  			cut -d' ' -f$field)
> -		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
> +		tst_rhost_run -s -c "nfsstat $opt" | grep -q "$calls"
>  	fi

>  	if ! tst_is_int "$calls"; then

