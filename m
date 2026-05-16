Return-Path: <linux-nfs+bounces-21656-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PqyMLWDCGrntAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21656-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 16:48:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC3D55C2AF
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB2303004437
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6803D5674;
	Sat, 16 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmCMUw2w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0027587D;
	Sat, 16 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942893; cv=none; b=UvQCdoxRZoJ8iINDGz4FumH1YLMYkHYudXfUo9DXjHp/IWV9vUKZyWy0Je8iE6g1Q8bWJSPuZxOltN8evOOyAAnlXqKPilz8qca+NRDFEpOmvEnqLV4Ylv6AMS3ZN8OdscsNM0CDcmb8dIy0iUkKQ4VmnYhEwTg13WTQ9BOT9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942893; c=relaxed/simple;
	bh=7VKUyExfAKl6AIwgWrTe81uA918+1Nlb2thIYy7wew0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCPtszt6DrWtzpegljzdk8FOFytfh6YibCosjb0mcwBRAsQgcdNu6oAzMrw+vOL9U3jxLUrzylWE5q8hnc4T7PhrC8S0vgJEJ6SzT4YCpmSQAfUrJydjtlJSwqVoDoJ09p5JlQ5ydEnsSyvrxL0wEGhgeE5kC/jHvOho3BkYiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmCMUw2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C461BC19425;
	Sat, 16 May 2026 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778942893;
	bh=7VKUyExfAKl6AIwgWrTe81uA918+1Nlb2thIYy7wew0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kmCMUw2wAu2HkSbRkoupAhLOXnjqM12FHAs2KElCaFrONYwgYk2vYb0j7YYOpHeCa
	 N+S2jUgpYKJ6ztqopeRqYBV9zRykHAXXqdYnkQEC6acv4C0j/wwgtHGNGHQVNlWKvN
	 dPsrPSddnFN0sDy04Zfk9ZyMhQpx3QPvmPmEInI7qq/tbj7NBnbeUQ4/s6ZEmawm4u
	 EiP+KaZ9XpyVG6szke+fZ2+PJe+tz4U1TVDkuW3BkrdGo/VHSXd7KErOcnAP/SQG7B
	 6lVhvYT3oJdGI/p7u6rXpzGQxf4SOtQ3g8uWA2EcFb2DAjjFgp9dRz8pFoxZyaD2KW
	 pi+DBfaRE95TA==
Message-ID: <bd45e387-cc11-4d19-8bd6-58a0251d7714@kernel.org>
Date: Sat, 16 May 2026 10:48:09 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org,
 hansg@kernel.org, senozhatsky@chromium.org,
 "Darrick J. Wong" <djwong@kernel.org>,
 Roland Mainz <roland.mainz@nrubsig.org>,
 Steve French <stfrench@microsoft.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
 <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DBC3D55C2AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21656-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/26 2:43 AM, Cedric Blancher wrote:
> On Mon, 11 May 2026 at 16:11, Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
>>> Christian, let's lock this one in. I will post subsequent changes
>>> as delta patches.
>>>
>>> Following on from:
>>>
>>> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
>>>
>>> [...]
>>
>> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
>> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.
> 
> @Chuck Lever Thank you!
> 
> Does that mean the support for case-insensitive filesystems will work
> with Linux 7.2?

I don't want to make claims with 100% certainty, but we expect this
series to get merged into 7.2. It's early days, so there are likely to
be bugs -- there is so much subtle behavior under the covers.


-- 
Chuck Lever

