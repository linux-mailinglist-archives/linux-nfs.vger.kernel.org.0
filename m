Return-Path: <linux-nfs+bounces-18932-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ww83No28j2niTAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18932-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 01:06:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F313A19B
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 01:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E4A130055DB
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AA1FC7;
	Sat, 14 Feb 2026 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfcaring-info.20230601.gappssmtp.com header.i=@selfcaring-info.20230601.gappssmtp.com header.b="NELBXOZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC213EBF3B
	for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771027591; cv=pass; b=rtMMLiBEZY7JfW1MPLW7GTUzZP7gEiSlvhc3eG2RGjwKwbIQhRqDEoWpfQ/MCdZRaodyvlgg2bucc2280tgcB0bT/EduWiwIlzgBDPfIPSoRQ7QsTTmhB2zNPMqnNjznWhguzHTrGpL/7jCAfF61DBravhiD3/l2pNtcL3FD02E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771027591; c=relaxed/simple;
	bh=0fIebdV37JLmHnDJXs8eipD8bNouzsdrjWI8f3p6NdE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tHiVaI9ZBvGhdfI+yjcxflepBdid75W+i3RDw5n//oTQQuCnu9SqaAItXe/drTLt1mrRx0XTHZo5THIRLoUH1W5EzGdU3/ILLq6jYuMk3ETkSg0vNziSIzav5FT3E7i/8hoakcuKMOcErk+R5KY5yjWYLzUwg/Ii036bnh6RXz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=selfcaring.info; spf=pass smtp.mailfrom=selfcaring.info; dkim=pass (2048-bit key) header.d=selfcaring-info.20230601.gappssmtp.com header.i=@selfcaring-info.20230601.gappssmtp.com header.b=NELBXOZA; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=selfcaring.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selfcaring.info
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso868168a91.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 16:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771027590; cv=none;
        d=google.com; s=arc-20240605;
        b=OkZlbai3ISSPEX4dkER4qdK7EChDOEZ3/XYK9iLoOpFe9QYxAiwFD27WcKd0xynxJe
         69ZL/6PnVrQuii2Bikigp9zkLsGwxL+5lMrPZYMSwzca4kLfJprwry2L+TYtJimXSn1j
         dQtNuUzCW9RncASxCWon6ZKYwOqIpRi7BLjXVqCNdfUAHAQUZJlCLHmKhjUsuuQA/GHW
         tq9440Zyw0xZqpW6ogTZ4qiDd8VTbLuBljZnYykWi03QcqyiePwKOIJRem8vtQoQCcTQ
         2yeDNYXnvZAOx+xKwvQfPTf6vm84ZEPo16OxyCSrvY1OEa7G9o1l5dSpfJ9raPA6G9IQ
         qf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=0fIebdV37JLmHnDJXs8eipD8bNouzsdrjWI8f3p6NdE=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=R7gQeyYD0ADkDzjH9MqRrv6LAPHaygE7Jk2LDkic+R0f0CgsG9RIRYASkarTfkO/hI
         Zz0xsz1PxUHVqzoZFt84d5wGEedxHnzBKTudrPsM4tU4orUjJ3OjDdYJCHsjvTrXFq3W
         EkaR+a3+I9YEm87JCvME7ppsF4Czak2D25K0iSH7UDpTPIpiQnCCCP3bWA+oSWn9kPuQ
         pcZKHuyQs9C4qVyyKLgj684h0ZRGANR0rPCsvExKbDyCsY11ErnQnjeJfVMp5OVMiX/a
         Pm95uMjoynisGbcXVpS51W/u0NYPEaif64D4ojFWHpkGjY/PlIdYAUJycyCRSiWmfmeO
         GZYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfcaring-info.20230601.gappssmtp.com; s=20230601; t=1771027590; x=1771632390; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0fIebdV37JLmHnDJXs8eipD8bNouzsdrjWI8f3p6NdE=;
        b=NELBXOZAsnmwPgL3C/PFPEeNIrHUIKuiHMkd7AyH9yR0VBclxkk90n1xikWO5vgt0t
         EtqgdXZ0PRg2hdzyoIsLRiCNFiW3ylimown60IyCxbwTu3DIcYrBLYAVHRwOa9/hUWKl
         XuceutH+aEAEIIyUx6oTqBtC5oRerx+qgqjbnf68Bxo07XSPlspvcx+tQP4ggdP6chch
         8ZHXZOYd6v84K8cxXdBczs4EaJSXQ1g4glzB0vQCdnsbO+kPZPWhxuJrhIZ9IK1n7Vwq
         V1pSQ6jdZ8c/S3j28DofdyGBBrlv6+OeudvMNW0VW0yYIZTQyStlWu7+6ruWhLG97SXw
         /WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771027590; x=1771632390;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fIebdV37JLmHnDJXs8eipD8bNouzsdrjWI8f3p6NdE=;
        b=wPChscJNW56sm8iW0bYumWE416M+L8U4/ZRQjWcLWj3S7KPHEjJiudCm3K9hQq8jlD
         ZpBlws+894poM9a1uUtAFJwvQX8vdK/LLK6IdAXBV3dEO1Ona+8fJavJOIQytWky38Sd
         NHioEf4OfsCNMTqtuWsazURbFzUMS/M5xWvlYnZ3FNAQfqFu7DBknRKxvKZ7z4h34JlV
         1w8o1bvCTbP+J8fAku4GWycZaZk+K1po27pfWJFJRwFxYTCrVPCxKPVKdS1shAyZlSqb
         phPOag0KNlavsCZ/9BeBSCZhQzC+tqVscaX/xGIuEzyWELLX5HZdPz7ILCOkdtlLqFH5
         qiUg==
X-Gm-Message-State: AOJu0YzFZaf+J2cnW2oFRtutmkAXl31LqUCzfgVK4G1EQDdN5B6+ijMt
	n0zu9uN+6UnBtjLHem6STpwVGCcz2KdhL8VMsdaz0yBefyOsoRyaul43wymqKbqIo+g3zPoYl4v
	+mTN7ArXj7F6CJfbZsRJWPvDJoR/itDDfvgU73yvdRsr6YtU/cr/G
X-Gm-Gg: AZuq6aK5ip2uQCB6YaBNNxJyz+0WxNYgIzauRjH6gKqR5egUOrH1zmkw8DH5LFQOOcf
	US/kN3U5je5RyFbStDiwHlVaq5HzfWdX2homg5qI14Z+wzgDNcRfH/YAa+emzezwUYxWzpeUNmP
	G7+BIdzs8Mapqj18Ym+KOOBeTlHrDCuwsX7V/oHWb/VCUszrs6ZzvAeq/4Y6ouXDVvg94lhCgqN
	FiHOtLYRArOSnk2aAwOZEewRBSZb0Z8dmWbNnX7O25q+mzN8BfxzDdgoKD/rwOfDoNEDfgwGqzB
	xbuhRVWPtAEnMLpvJb2SsB3IEF7bj/lZNmSIx04=
X-Received: by 2002:a17:90a:dfc7:b0:356:2bda:a857 with SMTP id
 98e67ed59e1d1-356aad3cbd7mr3759425a91.18.1771027589775; Fri, 13 Feb 2026
 16:06:29 -0800 (PST)
Received: from 785115219520 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 18:06:29 -0600
Received: from 785115219520 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 18:06:29 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brad Krause <bkrause@selfcaring.info>
Date: Fri, 13 Feb 2026 18:06:29 -0600
X-Gm-Features: AZwV_Qgi9lbvTlG3SVVVsIWs15-R7zsK1zJMkENw9t7eNMHPZfwDfva-ufyN7JM
Message-ID: <CAP04xS6ro73sRJ8rD2UxZChDcgFkEU4gFZ-AWGr-dsjDdoiEsg@mail.gmail.com>
Subject: Could you please double-check this for me?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[selfcaring-info.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[selfcaring.info : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[selfcaring-info.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-18932-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bkrause@selfcaring.info,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,selfcaring-info.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DE0F313A19B
X-Rspamd-Action: no action

Hi,

Dealing with cancer involves much more than just managing the physical
symptoms. It=E2=80=99s also about nurturing emotional and spiritual
well-being. Simple self-care practices like deep breathing, nutritious
eating, regular exercise, and setting healthy boundaries can do
wonders to your body.

I=E2=80=99d love to write an article for your site that delves into these
strategies, offering great tips to help those battling cancer feel
more empowered and cared for.

Let me know if this piece could earn a spot on your site, and I=E2=80=99ll
send it over to you right away!

Warm regards,
Brad Krause of SelfCaring.info
Be the best you that you can be.


P.S. Not a fan of this idea? Just say the word - I=E2=80=99ll whip up a new
topic that clicks with your site and still shines in AI and search.

