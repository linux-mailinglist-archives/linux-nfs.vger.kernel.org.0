Return-Path: <linux-nfs+bounces-1860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C979F84E36C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE0284BDE
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DA6EB4B;
	Thu,  8 Feb 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EZCEjFcD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyW/zj9u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EZCEjFcD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyW/zj9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50569300
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403492; cv=none; b=SlPz8u/FgU4B3LOX8wx/sbxPA8PAj2yX4XCAnXf+Zqv7EWq5TtrMnAUYu3zSzmwjiZ0xg8ib3pIH9yT3KtszM1A+6i6vZLPVmFL7sTE9x0Pw+pOu8QXEZ3Bi/tOEhxj0IDonOAKq8MHiERaiypPR1kzXjtzsKLeucHxcew3M3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403492; c=relaxed/simple;
	bh=39y3pCGzNwUzYEocTlBp8R6qOdz2CaqjGRUkB/QmnQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLtDjt3JPo19zOCjY6ALcXgszzNF0nqxDKFnUNV/ApLyrjkOReqm/MHroYJhyQRoyQy8g8jX1rkt0UmGAXLhvbVr8ADjLZ5icT9vzbSR94gkOZOLeDwTvGUKMdKRJBor1Xcm0z+xV6r6PwQd1ePuGY3P92OUwL7YDk7sn7o9Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EZCEjFcD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyW/zj9u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EZCEjFcD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyW/zj9u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 920E221F95;
	Thu,  8 Feb 2024 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707403488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeYjsOIuyZWJkypaa+8/BznO8amu9nLucH32jby0UQU=;
	b=EZCEjFcD9Tt7D5uUn+ESmPOx0kLcxPDC1deSleqS9j+tIXrPDQZtTwRDTFOlg8qniNEgK+
	Bk5iWds1/Abe2esHEX1YEqoxwf1KKdVlJobhwHGRrPrym9K7OjPRKyyJUGT09oZTkv7TKE
	2NNOyCEc2sJwb/iM7Ahqiv5G6nqqTxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707403488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeYjsOIuyZWJkypaa+8/BznO8amu9nLucH32jby0UQU=;
	b=NyW/zj9uIYuCOBfzZEnbOWOsAFTXQFxAYiFJ8W5yBF4AolxwsWSDEU4+yRsxkO5TT5f9JJ
	GZYxlS1+TyzVnoDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707403488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeYjsOIuyZWJkypaa+8/BznO8amu9nLucH32jby0UQU=;
	b=EZCEjFcD9Tt7D5uUn+ESmPOx0kLcxPDC1deSleqS9j+tIXrPDQZtTwRDTFOlg8qniNEgK+
	Bk5iWds1/Abe2esHEX1YEqoxwf1KKdVlJobhwHGRrPrym9K7OjPRKyyJUGT09oZTkv7TKE
	2NNOyCEc2sJwb/iM7Ahqiv5G6nqqTxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707403488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeYjsOIuyZWJkypaa+8/BznO8amu9nLucH32jby0UQU=;
	b=NyW/zj9uIYuCOBfzZEnbOWOsAFTXQFxAYiFJ8W5yBF4AolxwsWSDEU4+yRsxkO5TT5f9JJ
	GZYxlS1+TyzVnoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F3BF1326D;
	Thu,  8 Feb 2024 14:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v3UXBODoxGWTagAAD6G6ig
	(envelope-from <mdoucha@suse.cz>); Thu, 08 Feb 2024 14:44:48 +0000
Message-ID: <1ad65f0c-430c-4805-83eb-81198303a888@suse.cz>
Date: Thu, 8 Feb 2024 15:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nfsstat01.sh: Run on all NFS versions, TCP and UDP
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Cyril Hrubis <chrubis@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
 <20240131151446.936281-5-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240131151446.936281-5-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EZCEjFcD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="NyW/zj9u"
X-Spamd-Result: default: False [-0.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[31.13%];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.30
X-Rspamd-Queue-Id: 920E221F95
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Hi,
for the whole patchset:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 31. 01. 24 16:14, Petr Vorel wrote:
> Due fix in previous version we can run nfsstat01.sh on all NFS versions
> (added NFSv4, NFSv4.1, NFSv4.2) and on TCP and UDP.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   runtest/net.nfs | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 463c95c37..9c1c5c63e 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -94,7 +94,16 @@ nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
>   nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
>   nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
>   
> -nfsstat01_v30 nfsstat01.sh -v 3
> +nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
> +nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
> +nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
> +nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
> +nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
> +nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
> +nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
> +nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
> +nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
> +nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
>   
>   fsx_v30_ip4u fsx.sh -v 3 -t udp
>   fsx_v30_ip4t fsx.sh -v 3 -t tcp

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


