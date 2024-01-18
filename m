Return-Path: <linux-nfs+bounces-1195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE1883108B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 01:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7016E282A8A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9F184C;
	Thu, 18 Jan 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IWYN0S1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+f1UuksH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IWYN0S1f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+f1UuksH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474B1844;
	Thu, 18 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538174; cv=none; b=dQqwHEgRhTfJm5MzXuWPwgCRoAtw6N+honYWpF77yDmdpnwTejMqlXbo8f0NsbR4Mf8SWkIk6xHDXE4dNHxLIl2a6eSmIoUzAO5JVSBPLYbtjDZgh4M5cevacV4SvErvMVry3R667urbDyCLGgJX8EyJ0adG65dopUI+YTm9fXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538174; c=relaxed/simple;
	bh=XLYZFGvIZV8uVcSXIeH6bGXkgQ1kCjHxF5UD5PUQCoM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=jSGS69dgnahmLUkv56myxn5Snpy5/S48Qh7w6BtplVanASpNIhb6BE7iJv8JDKsZCEy5jdaQWsn+YCasFEL8tclZYVtvTCqXKWZCC/XFGVNu06HG5qxShLhwEMge4A/V7MRR29F9WdG3YwgrReIJypRbwBI6x+Izf4n610lftYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IWYN0S1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+f1UuksH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IWYN0S1f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+f1UuksH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1123821FD1;
	Thu, 18 Jan 2024 00:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705538170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y95FJPhtJ5EtQaLPfTk7HvfFF4nbcDaWOJ7hVa4IuE=;
	b=IWYN0S1fNo7PdW60lgB6bQR0KZcuq7zP5Fbuv70A+cMvaCvyrGWK4v9IHxRx8gNuZSCV96
	hUd/HIqB/TKU52XqEKWQPbM6544ud+o1LQZhfNGyzY8rnsC3mhXb2CLVNTSI3Qavhb8R+3
	36d0edzcAXrI4h1EUrH81I4TZvjr6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705538170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y95FJPhtJ5EtQaLPfTk7HvfFF4nbcDaWOJ7hVa4IuE=;
	b=+f1UuksHiqeCsrEjA39+ufKa1uSZTs2xP23mKixYSTMCr8pQad3OGxKHhgVdhck4S5Z5Ns
	kiS2L30MgkK+gQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705538170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y95FJPhtJ5EtQaLPfTk7HvfFF4nbcDaWOJ7hVa4IuE=;
	b=IWYN0S1fNo7PdW60lgB6bQR0KZcuq7zP5Fbuv70A+cMvaCvyrGWK4v9IHxRx8gNuZSCV96
	hUd/HIqB/TKU52XqEKWQPbM6544ud+o1LQZhfNGyzY8rnsC3mhXb2CLVNTSI3Qavhb8R+3
	36d0edzcAXrI4h1EUrH81I4TZvjr6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705538170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y95FJPhtJ5EtQaLPfTk7HvfFF4nbcDaWOJ7hVa4IuE=;
	b=+f1UuksHiqeCsrEjA39+ufKa1uSZTs2xP23mKixYSTMCr8pQad3OGxKHhgVdhck4S5Z5Ns
	kiS2L30MgkK+gQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA5F136F5;
	Thu, 18 Jan 2024 00:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5baBEnhyqGUxNAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 18 Jan 2024 00:36:08 +0000
Date: Thu, 18 Jan 2024 11:36:01 +1100
From: David Disseldorp <ddiss@suse.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH fstests] common/rc: NFSv2/3 do not support negative
 timestamps
Message-ID: <20240118113601.760290cb@echidna>
In-Reply-To: <20240116173127.238994-1-jlayton@kernel.org>
References: <20240116173127.238994-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IWYN0S1f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+f1UuksH
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1123821FD1
X-Spam-Flag: NO

On Tue, 16 Jan 2024 12:31:27 -0500, Jeff Layton wrote:

> The NFSv2 and v3 protocols use unsigned values for timestamps. Fix
> _require_negative_timestamps() to check the NFS version and _notrun if
> it's 2 or 3.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a9e0ba7e22f1..d4ac0744fab0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2902,6 +2902,27 @@ _require_debugfs()
>      [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
>  }
>  
> +#
> +# Return the version of NFS in use on the mount on $1. Returns 0
> +# if it's not NFS.
> +#
> +_nfs_version()
> +{
> +	local mountpoint=$1
> +	local nfsvers=""
> +
> +	case "$FSTYP" in
> +	nfs*)
> +		nfsvers=`_mount | grep $1 | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
> +		;;
> +	*)
> +		nfsvers="0"
> +		;;
> +	esac
> +
> +	echo "$nfsvers"
> +}
> +
>  # The default behavior of SEEK_HOLE is to always return EOF.
>  # Filesystems that implement non-default behavior return the offset
>  # of holes with SEEK_HOLE. There is no way to query the filesystem
> @@ -2925,7 +2946,7 @@ _fstyp_has_non_default_seek_data_hole()
>  	nfs*)
>  		# NFSv2, NFSv3, and NFSv4.0/4.1 only support default behavior of SEEK_HOLE,
>  		# while NFSv4.2 supports non-default behavior
> -		local nfsvers=`_mount() | grep $TEST_DEV | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
> +		local nfsvers=$( _nfs_version "$TEST_DIR" )
>  		[ "$nfsvers" = "4.2" ]
>  		return $?
>  		;;
> @@ -5129,6 +5150,16 @@ _require_negative_timestamps() {
>  	ceph|exfat)
>  		_notrun "$FSTYP does not support negative timestamps"
>  		;;
> +	nfs*)
> +		#
> +		# NFSv2/3 timestamps use 32-bit unsigned values, and so
> +		# cannot represent values prior to the epoch
> +		#
> +		local nfsvers=$( _nfs_version "$TEST_DIR" )
> +		if [ "$nfsvers" = "2" -o "$nfsvers" = "3" ]; then
> +			_notrun "$FSTYP version $nfsvers does not support negative timestamps"
> +		fi
> +		;;
>  	esac
>  }

Nit: It looks like there's quite some overlap with the existing
_is_nfs_version() / _fs_options() helpers, but it's still an improvement
on what's currently there...
Reviewed-by: David Disseldorp <ddiss@suse.de>

