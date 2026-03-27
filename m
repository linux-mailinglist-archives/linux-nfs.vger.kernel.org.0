Return-Path: <linux-nfs+bounces-20460-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBzUAKCSxmkyMAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20460-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:22:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C75345FB0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4297830383A3
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA193F0AB1;
	Fri, 27 Mar 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyLdqguO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925522D7B5;
	Fri, 27 Mar 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621136; cv=none; b=uY4BZ4rg3vpDisOwA/RkvXAs8A2sTchZs8RxSsQqm6ePeAoLyKcr4Pl70P1dISV/hDvAjJCuN5Rv3/eJPE96PoenpCS0H2VBXObZzL9TIlPQZvIWj0QMS5IMqX6a89nqDDUsbY1ZS1XXogqbTuOA16wo7Ron7SAoqYDS+jLGliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621136; c=relaxed/simple;
	bh=AV6sUZoqH5ubaTfUhDSgDNwIG4akSDpKH01tnRVSKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOG0um1B7/+9LakyAkKEJpoRKjSVRCaWdkvjKkvfG9NZR4UGViq4vhw6XlDT0WAaCnJeuE5QF0NQ9R5kj9A/cqmSkrOlNwxEHiUYvmaALleMBZnIFJiu1IuSxqqm+vPF9prXrJzM1Pu7n/uTkosM8Zp4FxlgYvGFK9HPXZkEujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyLdqguO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688FAC19423;
	Fri, 27 Mar 2026 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621136;
	bh=AV6sUZoqH5ubaTfUhDSgDNwIG4akSDpKH01tnRVSKV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MyLdqguOM7XNyZv7SGpB0OwYr3GV3LDqSWxiVU1rHeB1ZqBzZPwjb/SJnFRG5Iwqo
	 v/lzdkgyEDJclqUJiR02GYWLjRBolvQ+UGGkpHSPRRNMnhgu4p5DgO2dAiVgXAAVyC
	 XmIcQtHhECjdUowp0tIOj09MfIFkDpmOyfcAt7SSk+Ry6ZrjiHYpE5omjBqmuml9ag
	 vl9ZhW6svW5qcBKsxY0NNUfYDCZke9kkRRdYo9ZluXUYOWuC0oL5JuNp8uHTRpQ0v5
	 Ir7z4Ax/27v/WCfA6SnSSWUZFEiBk1F2VdTgUK/qhndw5Rhb/khYmAzz8LcROqGhgt
	 kJ6dUUR3pywEQ==
Message-ID: <4debf9fc-bcc9-45ce-bf44-2abc1eea3c4c@kernel.org>
Date: Fri, 27 Mar 2026 10:18:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
 <20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570@oracle.com>
 <36a2588cab11af2a395b356163ee6ade93665ad4.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <36a2588cab11af2a395b356163ee6ade93665ad4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20460-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3C75345FB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 8:21 AM, Jeff Layton wrote:
> On Thu, 2026-03-26 at 13:55 -0400, Chuck Lever wrote:
>> +	case SC_TYPE_DELEG:
>> +		/*
>> +		 * Extra reference guards against concurrent FREE_STATEID.
>> +		 */
>> +		refcount_inc(&stid->sc_count);
>> +		dp = delegstateid(stid);
>> +		spin_lock(&state_lock);
> 
> Oh hah, just noticed the kernel test robot pointed out the above.
> Should be nn->deleg_lock now, no?

Ja, I rebased just before sending these yesterday. Duh.


-- 
Chuck Lever

