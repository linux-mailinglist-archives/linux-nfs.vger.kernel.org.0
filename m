Return-Path: <linux-nfs+bounces-18937-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJZ7DPi+kGkVcwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18937-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 19:29:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27A13CE27
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B1B301808D
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC32FFDE3;
	Sat, 14 Feb 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3FJ5VEx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOrKPF7F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE223C8A0
	for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093745; cv=none; b=DpNEeOjjS4EtMj8XqbWNsWK4ZoGpctGYlpKqK09VqwamG82WfULpvwXP4/cYsNHEus2ognnq+D2d4yqD1E8UuwD1PL1Kbn3MQ3jfXBY8Oez3j3cypNAj5E/UhaFCKVhCjaW9wjBFU8Lj2lERtTD814s6QyfSg6FpJfXfA0sWRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093745; c=relaxed/simple;
	bh=xgketm8c2mX6Go7ZUAVxbeJVFbH/hWwVLL5KIsUCjIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5AXiuoZbb/FkIk9dsXkFy8H82rl5z461mJT6X9ULw00vn7tVBtDv2CaPJYy4deRYuVIU2kD897oHfLP8cQ5QigJ0WsfPfXTRGWkEnvKlhzDDddvtxh9W82t/Oy5Y8WgXWRcMle4C+kzROxKduEBkoYwHiD+ZZXaRTVHia6KIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3FJ5VEx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOrKPF7F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771093742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
	b=O3FJ5VEx5aPPgm3sI6o+y89AR73KPy+bUjazpUs/ehlZ03tOGiomnsTLG/d7R+4Y1Ugg7Z
	tNkpx8BC9dD3QSqUBIy1Ifbb42lJPfo/1EGE5jNfX2ekV6mYpFW4JvWsbD4OxX6x4UvlWC
	WKVsbh6xCfxXjMt+xqaQOK26kcrGO3o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-v7NwZc8vNMeYOre9ndphQg-1; Sat, 14 Feb 2026 13:29:01 -0500
X-MC-Unique: v7NwZc8vNMeYOre9ndphQg-1
X-Mimecast-MFC-AGG-ID: v7NwZc8vNMeYOre9ndphQg_1771093741
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-896ff58f17aso111831796d6.2
        for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771093740; x=1771698540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
        b=DOrKPF7FRj6kJQRhU8Z5BbXc2TLaxeb210Y/B6Q+pPrl1OyYRadygDSNnZH1Ls83Y1
         ngR53jKAcOclbG6I3OuGuWFqqLWBwq4fWizSXhHfHP/ZGIficvyG6od4kphvgOCxG/rN
         f9MV7ELJywhmcVnjQuJ1FQw6jAWRexV7qxDQ4u+5ZxgNdasNjmxgoqWamKPs7uA4jtsL
         JjslHuAKLqTulJ5PtgS/W6fsJ2DlGtEoF6dlG79hLNBJVZuU4IYh77+gE94MAGt9ZczD
         fErqgjq8QTzrA+DTgKBEWcbj1b4GbU00H/q0o31i+jCzbrvfEPr9s79OexfxnDstf36m
         RADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093740; x=1771698540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
        b=UyMYPlPoxU31dtqLtdTiIiyiqBmBEYAFZjpsH5EvPcpisX5iMr4XFHdaY++MpBi026
         31uCPOr1SgzvRIo5niLCOC6eyEPRDQ8hTEHTuh6P/0hv3Ct0eLUCF7ynsmHoNnXJAlY9
         vGR6VZA3fzqqK5lZWsZ3w0ixOOo4ERH7q7Lc5fuZlKgckKhFXYio2WvVLcdY01xkp/mw
         b7s1A5rFNg33FchNRmR1vW6Dt4sFhza17vZ5sHw3nP0Z2BdyQaz32qm1MTAoVg7V2wXv
         LQz3eOCH7HPNfKnLeECfW6mDyE1TEtt4drq9WJLYzW+d9PEB3wuzDVfZsJv1WS6FFZC7
         w0bQ==
X-Gm-Message-State: AOJu0YxpQm5gusXsP6z3b+5cv8px0Cz9s603OaeLawryKkJlmlN+Nuh7
	tw5jH2LpjCXpRapUzhLnUNNsMfvAx3zhbU2FDjTPOslhzbMQdJ9QSBNg2L5N++3x8VourgmwRMv
	bvk62bwrfNLyK1nHlthabKibPN4SwxNVO5Ky/DP3b5g50xwGbPaD2FErszN5DR5A/Ecx9NQ==
X-Gm-Gg: AZuq6aIkeWujigTFoWmtrd/GNdRct7dRBl4YicxhxbhocmcQ3x6SCzHiWo64NXYF8DH
	biRnq40jv0HSOghZrRtoj1AiHP17Z0xnHA8ygCk/IiLwfCh4EAycCFAdvgebnEqRoSEKD2vv56p
	jfEUFJBIAayrgHzRzEHpt3mYt4zCXLDNDJ29bvvphApXfrYaCPQgvozsWOCu+MBCdH6xqBnTTrb
	kLTRuPTAQU/X3mY5KAhYhvfcvPC6y8mN6NB6JMTu414D9pphJfV3yKA3YYkiZsnq3iRy7r9w8c/
	fW0RCmSiTvHTzjFPi/SbygeJ92t9RYhbJQe3H9rS6JRMGCJqK2YiAVBxsiqBL18hWyDvS8FgLWe
	YN7R/5FPFvU6OKTOvM9Ia
X-Received: by 2002:a05:620a:3710:b0:8c7:fdc:e853 with SMTP id af79cd13be357-8cb4225fbe0mr756915885a.1.1771093740200;
        Sat, 14 Feb 2026 10:29:00 -0800 (PST)
X-Received: by 2002:a05:620a:3710:b0:8c7:fdc:e853 with SMTP id af79cd13be357-8cb4225fbe0mr756914585a.1.1771093739817;
        Sat, 14 Feb 2026 10:28:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f5desm878549385a.41.2026.02.14.10.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 10:28:58 -0800 (PST)
Message-ID: <dfd0d59a-a0ca-484d-981a-55cac8d89717@redhat.com>
Date: Sat, 14 Feb 2026 13:28:56 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: nfs-utils-2.8.5 released.
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
 <aYlpcPkq_glykQvJ@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aYlpcPkq_glykQvJ@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18937-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A27A13CE27
X-Rspamd-Action: no action



On 2/8/26 11:58 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Mon, Feb 02, 2026 at 06:45:30AM -0500, Steve Dickson wrote:
>> Hello,
>>
>> This release contains the following:
>>
>>      * Man page corrections
>>      * min-threads parameter added to nfsdctl.
>>      * systemd updates to rpc-statd-notify.
>>      * blkmapd not built by default (--enable-blkmapd to re-enable)
>>      * A number of other bug fixes.
>>
>> The tarballs can be found in
>>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
>> or
>>    http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5
>>
>> The change log is in
>>     https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
>> or
>>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog
>>
>>
>> The git tree is at:
>>     git://linux-nfs.org/~steved/nfs-utils
> 
> While 2.8.5 was released, I do not see yet a release commit and tag in
> the git repository, is this correct?
Sorry I was traveling and forgot do the push... It is there now.

steved.

> 
> Regards,
> Salvatore
> 


