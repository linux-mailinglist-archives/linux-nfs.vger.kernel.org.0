Return-Path: <linux-nfs+bounces-22303-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ARiOgTEImqidQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22303-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 14:41:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AAA64841A
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 14:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=kztQ87zR;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22303-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22303-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36306301F983
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F91CEAC2;
	Fri,  5 Jun 2026 12:29:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44268318EE2
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 12:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662585; cv=none; b=UGCw+VVwxn6RylNywSXXdokWIdhqQNwm3Fw2jlPK3dMv69Y9WrNLwn8qt+G+iXsRyFhfnXjf5fMWY4AoA35X4btdCyLgV7sMUlCdaI/COcXidRPf+yuTCWyFXpdUa0Ma5CGED7MxBUECKlpP8dlnlRMTVsif+ElFUt4HXauX+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662585; c=relaxed/simple;
	bh=64O7JTUJU2f5BXNSYc12DPUbUZRAd8d9+bNKTyvJ8Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue0kDV3FhiXS+K7Ee+owh18vOs0vRHWlwTQsw4x9CiJbUyN9azom38jrSHF+s4e6rktOx/DMrShZaACGixtz7dobYI1r1r8xlWxHo6clF/jDb73tXzfaCDZSZ+7PWg7ISgkbaeLgZZhqNjvnlTIhrZ5L02wuNln65d8UkFoiND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=kztQ87zR; arc=none smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48611d28204so737085b6e.3
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780662583; x=1781267383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88bDpIU2JtI4JhHvzemDkWMxWUW6z+PC6LJPuSb0Fuc=;
        b=kztQ87zR2T5bX+xvqsdjJUqUhLda0wSqmQHd4+vb//VuoN4WXTFKc2GEDZuWI6Xc0f
         JOhq5eACGak0PkPRfLOI4xDIQpUXzRzrJCXX+uW+5RmzEBZbfnmQWeKNRbJdvy/N5llb
         7eZj7n0ZMPd7JEsbnud2Y+/Z9lgJSh7ENz0pWNO+1jVpDDFtiAnN0pFGirxlu8K2dEOz
         I0et2O3mqDeg46vFwnCHqTl0xqD77hjefLGF1GaXSRtasnbC7sMg91ThM7jFrN+ky/LF
         bB5ywfCDx1/vs1m3z+SEthTnsQiIr8AMTxnUvGp3BswurhFPyUV1Rol6WTYi+nwSxIuv
         4AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662583; x=1781267383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88bDpIU2JtI4JhHvzemDkWMxWUW6z+PC6LJPuSb0Fuc=;
        b=mTwFQ8p4Q+izfswrR8upB6AdcZ7MAdsAY3IbO1/zqX4WdsWXOeC9gGhv5wmHUW9HMs
         E0OrjBKAXnk4Lke8OhGkB2gv53yp5jzL3IeXrL+sFlf0wST48mcr1fQ6IpDKuE+i95IZ
         Z86wQNvwf8ahtXznkYtvEugdY3bZKRLQTf7CdSVsf9tqppniPRGuzCFkRp1/ss43mHD3
         OJIMf+e4guUFXEq7z147Iev/m9oK7OQqHqXi8MwhMSZCHtgsIWS+PJn8/p44EZKhBO2U
         e0rAkgfU8YriXKf61YVfUKUwmTFjJYs4IqndswzeF4DZEHF1XKxZ/GPCMSpuwEnLd6ST
         XRvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Km+ECQOCjMkjqSR3RDaG7N6T36xh/U/EVaupioKnUuwqN60pJOPu0zDHAFvnTF7TgUW00f56v7h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDNRopWNgjXIAWVKQ8JOvE97BLp6WHpshfvK5ua1o788OeJfx
	OyZMVeBvJHTEmy5MK5IcFwdO/xRrMwXNuwdspdEsZdmKMvBNSxCfRu+3IP7Wzr10B1A=
X-Gm-Gg: Acq92OFBnbwIFqcZRNgXdzbHOPO3PZo8+hTb1tFCfKYC8x2kmKe4E0el6cEW/uNT0rW
	IV37lboy1cNb044JAEFbT166/wBJX08Fo9rMfF3A4tT33ctuzzdS/rbiPdjb1A/eptv8IVr43Xv
	7vfAXFBmRkC7CEatKfJfJ0L1v+U3JGYXNqOK1tLR3YtrPhiafGefO1zKGCKo26LXrNO4WhbgSBc
	f9Z13fb4aUYzqDbx5dKRJuqNHuDzHpe2wssnF42LzEVWYcCyGh5sV0TgfFUp7YEX26vQncHMXdQ
	rH2NbJYsUKFd0Ha4t6iKd+g+8LC5xio9T5j7cletawnpSW15Ll1OvoA9+XsdPtIphLZEEQ7K5x2
	ZMSd3y7fkkz4qcqcwwnH6XkLNXNeVgDMw4aa3L+PQPl0Zj9ribP+lqtPnlVQ0Nfh11VuX2pZsK4
	4JsvmvmdvJv0WV88wv1MPgv9T0raxQvaJkCmeDeomzMPrTZQJ4g96/Fg==
X-Received: by 2002:a05:6808:2e4e:b0:485:7c5a:63b5 with SMTP id 5614622812f47-4868db2da00mr1724106b6e.4.1780662582950;
        Fri, 05 Jun 2026 05:29:42 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b7ad946sm6576308b6e.8.2026.06.05.05.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:29:42 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Fri, 05 Jun 2026 08:29:40 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
In-Reply-To: <178060780940.3392745.3574880233025675236@noble.neil.brown.name>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
 <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
 <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
 <20555E8B-0E49-4328-8B31-0F73C3D286FE@hammerspace.com>
 <178060780940.3392745.3574880233025675236@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22303-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:from_mime,hammerspace.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02AAA64841A

On 4 Jun 2026, at 17:16, NeilBrown wrote:

> On Wed, 03 Jun 2026, Benjamin Coddington wrote:
>> On 2 Jun 2026, at 23:44, Chuck Lever wrote:
>>
>>> On Tue, Jun 2, 2026, at 3:53 PM, NeilBrown wrote:
>>
>>>> Idle clients will get pushed back to 1 slot, active client will tend
>>>> towards a "fair" share based on how comparatively busy they are.
>>>>
>>>> This wouldn't help for v3 of course but I don't think we need these
>>>> advanced features for v3.
>>>
>>> Ben’s employer might disagree with that :-)
>>
>> Yes - v3 is pretty important to us here.
>
> Can you remind me why v3 is important for you?  Is it the lower
> state-management overhead, or something else?

Flexfiles uses v3 in its data plane, and..

> Is there some way would could improve the v4 implementation or protocol
> to make it comparable to v3 for your use case?

I don't think so - the stateless nature of v3 gives it distinct advantages
(and disadvantages) over v4 for some use cases.  That property can't be
added to v4.

Also, because knfsd doesn't have different resource pools for each version
we're going to want to continue to balance the pool for all versions
exported.

Ben

