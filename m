Return-Path: <linux-nfs+bounces-19036-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGAaCwRll2n/xgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19036-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:31:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FCE1620B0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7553007667
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9C2F5A12;
	Thu, 19 Feb 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrcL/hIl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B7308F3E
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529473; cv=pass; b=cgeh30aOGJzT16ikUEqAoCbdKckIL4d5nOJnRRbeeI6Xnf1BOWZm+6hefHmKKSMOKF7bxPic1EL/SjbtJ8VmFuelQ5HgTSBQtM44v0LXTRAXCy1pOFokzF7CuHltZn3TBgd6WbBt0yJWCj19aSa5YUR/ydU36FageLhVMJC2hz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529473; c=relaxed/simple;
	bh=8VavJFRxfc5Lb0KRToA/hu+dfUXTyHYdagZyJJIupzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bp8WfCh1n7K+hQUkLr2jK0HRbXG2ESYHVRdhlC+3RkOb1hM0dIMgrDkdWY54XnjJlfEXvmWBwBo2xrVAgbhURN3P34BDky3ibQpCwL02Igs2cQx4vYYUrrQ2T5Rn2YqFCjFfUG5fH9WZu+eCDFkKDEzGRLo9MqDnhDbILScIlQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrcL/hIl; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-385e7cafef9so11170761fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 11:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771529470; cv=none;
        d=google.com; s=arc-20240605;
        b=FKWBth5Yyydw6LVeQPKIwM6d+/WC04mnwV0MnQceAQahJlNdBioWbpglD/Ol1qDbGi
         6cQfHdVI0XB9FSlHsxursqt/S8qNUJPjwfNbz6Wg2TYRlP9wI5HyCBzN9M/bBrjkzUsW
         qCC9/IXhKx6YpxsnUVBTeUPnU3d2fizJYTTaYKE0uTUbTwITlsXF8xHKqVqBjJFZIvwY
         IrAaNnrtx/uspHMmdMSuxXzqMP15tysKrSK4/7jCjmTbFir4SdNU3fO+rsJsW2h3G0PF
         Kuu2OPyr5/WwZdak0RCfrHpHS5snFPIZ2ukWFVmf2k49dj0dw5yrFhYbTEhcBi7r1AoZ
         GVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=HnrHbU397mBLY1xtHyN0zkVn1E0qDQNQ22HaXt5hINk=;
        fh=lN77LExV8ZtDk8iey3OYm5Np1dHMq+YMdTS7clW91VE=;
        b=MbyihSSO85B8xwKMS7kiljbh17LubMPqV0vOD1Pd/uJJPG7AAw6ktEz6HWr1/RsYGc
         8FOe7yDv6wBudZ3xZW9kqFQmWI925BQKpdWWRbts155T+GlzVRzJRF0GvnpUOkUvGsj6
         qUdBNL7MfWaJOikC22JjdjlJpG38YmPEbggZTlQBTSiCnascX3O/3jhW792Ywox8Y2CY
         4Wb5+LDEs83B91dIV+1tdKeWOdpvvIpV21Ti0RJOn32Dm+C9XKNsqH4jXZbPkoMrMb8t
         NPBeEl6z4CHowEkSQBG94PmSxhoKh4E0ATOKmgVWEktQDrzDW04ebnxYt8S6dsZzTjyV
         6AoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771529470; x=1772134270; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnrHbU397mBLY1xtHyN0zkVn1E0qDQNQ22HaXt5hINk=;
        b=NrcL/hIlINrYMmHwrspVaSybHsxjKZrjlCyqAwd1b9B1l/wjSVuXgBnyyXQWCCIjWF
         tpW6sGzY9Rd5kl2kCxQS51VZC5t814lR8+CD/L5U+Vx10YJOnEkssXai5UQscp3p8mAj
         4o3jEVzTkP3Bsx+3xax4tBPgl7rLZTZpZa0pcFcRt0nDfujBDMZSPJv5e6oRydrGz/TT
         BlGKYJgT5Lhioc4BeMwwfF5r4avAO8ybwhFZ2Au3pbFUBlMsTOmCQmtFQkkgThswXMq1
         VmpQQJO+L96FEim487XyZ1Oc+Abkqgk0wLeRQ5mlR7vKgtbSLH+uzym9K62ywaQwm620
         VRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529470; x=1772134270;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnrHbU397mBLY1xtHyN0zkVn1E0qDQNQ22HaXt5hINk=;
        b=exdVXQtW1Uv0k4jLTZ0RBE5OBrWkzKXKloWRsZjmLjtM3tiJDphwQ6x12JI05SBxeN
         VtP8mzkCNPflr3zjysKIqQEA3vss7yVEIFYfyOoRosRHDjdNDcuBRd+dlQAQ1UqS6PK9
         gIApqVJXXxZN3nzZYdYyHwCwJMMu/02QTfI3nlHL3YAyZow60ykGLjy9gQkOJ91E/Hfr
         mN1fxk9VBxdykQIEF4q49j4GvKE+j12WfJPXYD+vl8TSh6m87zsqrnb6rAwAmZy5rE3J
         7/CQTKrW3OMGh7EBPFvbXLzkU2ZLfpwsxsRJFxzE7D8TjmE1ySr86lVuetk1pHJbmLEe
         KRFg==
X-Forwarded-Encrypted: i=1; AJvYcCXdIlHYuOi1eIQ7MTbyyQAa2+oXROwH+GagWiAcjKET5olvS+NCsVjraB91+I76/9jDCUxzHL5yP3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+jDRfEAHzgeEAQNE+ItHUrGHHMdnHrbWmJinPziJP2oG5BpT
	RCN45qkLPHs8MgJV7CR6nC3fwyARrv9dTdhdFvBuN7NxnxccyPcXbn9jICUBpVvv+KjN5ZV8GVJ
	efmlAAfYI4TZPYvkO+Le8QXfZVirNMz/dfnAi
X-Gm-Gg: AZuq6aLbG25rwGC0fdaLLiDWJLDz4VsancuFig6weaBWylyDnmhbqYNYRJMn0IAvTvs
	FddSZVlFN8/j1eaQNApud3MUEyhpGuADkWpqyL1pnySgVFCGZjJDRXC7ZazHiaUIU3Qv8JYPU3l
	XaiLiXqZKEBAG4MbhI5xfq7XRvwqu2HvrytkayfZC7Va/gZt7yMfe89eQUbibV2REYO4cqTrROY
	QEiK3hkTq6cgRCWLeLiI5Cd+kjXH+RU1QDWe9OVFZxlT68GhnkI8tUN5XmBcUKE8G+5CbMwJF8L
	emg52dQ=
X-Received: by 2002:a05:6512:686:b0:59d:f71b:3608 with SMTP id
 2adb3069b0e04-59f02632deamr7454920e87.31.1771529470005; Thu, 19 Feb 2026
 11:31:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Uci_qXuuKcmNhwOwoCei5=AAHVW-sBLJi7wJHDYfAKYwQ@mail.gmail.com>
In-Reply-To: <CALXu0Uci_qXuuKcmNhwOwoCei5=AAHVW-sBLJi7wJHDYfAKYwQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 19 Feb 2026 20:30:32 +0100
X-Gm-Features: AaiRm51oc_pYcBzdqN0zrhMRxXe4xD-FJv75cuiulUpr171d_YvbfFqZUy2pdlQ
Message-ID: <CAAvCNcDLv095V70y9a-TN+7UTZJUpnHt9_xQMpmgbyF4Eb5aWg@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] Mount option to reject mount if given NFS
 share is not case-insenstive?
To: "ms-nfs41-client-devel@lists.sourceforge.net" <ms-nfs41-client-devel@lists.sourceforge.net>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19036-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4FCE1620B0
X-Rspamd-Action: no action

On Wed, 14 Jan 2026 at 14:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good afternoon!
>
> Would it make sense to have a mount.nfs(8) optin to reject the mount
> attempt if the NFS server reports that the share is not
> case-insensitive?
>
> The use case would be to prevent mounts which have the wrong case
> sensitive/insensitive flag by accident, ensuring proper operation if
> software requires a case-insensitive ot case-sensitive filesystem.

So /sbin/mount should fail if the spec (e.g. filesystem must be case
insensitive) is not met? What about if it matches, /sbin/mount
succeeds, but a NFSv4 referral refers to a filesystem which does not
match that spec? Which ERRNO should be returned if you do a cd
new-referred-fs123, or a open() which crosses the referal?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

