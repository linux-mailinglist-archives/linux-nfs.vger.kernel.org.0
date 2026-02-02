Return-Path: <linux-nfs+bounces-18640-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NHRD1mPgGkl+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-18640-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 12:49:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F5CBEA7
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480AD302F738
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Feb 2026 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5227F163;
	Mon,  2 Feb 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn/Y/26a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjnKx5gp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC436403F
	for <linux-nfs@vger.kernel.org>; Mon,  2 Feb 2026 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032737; cv=none; b=rEMLSNp7VXA406Wgi3QAn/SvwFMi6BgL4x9nYHRok21XzoWmru8+DRXDtY4+DbjMS5RVQJpwJtZZ8qIMHqINpJpB6sVH4B7d4wdgl8n5ntRwNm6f/I54EDp3YDBSdK3GLqC0OmrYmlpJMp1GMIB+xsxyExseuW7UovnVIqoeX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032737; c=relaxed/simple;
	bh=hUCc5qc1wPl0eDRsEu95AnTZAcSjNecW9O8G5FUbxEw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kd2co4LuTepiEy42whMOw7IYp2ntm/a0GCr+exuk4z0Q4XMwvCtLWtT5HyRYh+JF9YU77vVmdNdAFGphhM2E/P2vcgLueXTu/vj4zJ3Mpyf0v/AIUs/uL2L697X8sW6Ix9fsSQgtGfir/IaEsW6srVMH5i+6WgqG1Vory8qTos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn/Y/26a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjnKx5gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770032735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
	b=Mn/Y/26aBtyaXD5IKq6+rd8HBePz6x2MiAzMielfswC799t07HQocpq0iDKERtkEqBPrsm
	E9priVwBZ9owYcrhvNvlbE+emylBbUlzuVStj8Y86QQQeT1w5Ma4mD1b620D5cx+QYjRKp
	TBDx12/Vc4zvhu4KeFRW8YtJp+oCy34=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-QPrYbuObPQqwP8FQcTCodw-1; Mon, 02 Feb 2026 06:45:34 -0500
X-MC-Unique: QPrYbuObPQqwP8FQcTCodw-1
X-Mimecast-MFC-AGG-ID: QPrYbuObPQqwP8FQcTCodw_1770032734
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6ae763d03so452032985a.3
        for <linux-nfs@vger.kernel.org>; Mon, 02 Feb 2026 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770032732; x=1770637532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
        b=EjnKx5gp+YCVnzXrBP6ciXZPSFseW7xRreLS1dF6WZto0E4OC1AzX/aFa7jrJbFUJ/
         ESgDpNMOi5exmyzvW/75W6f5Qad16P81VRuzueGLDDgBcPbsWOJUjsHPgvQP3bYfduiZ
         uYp5uJjnk0O1cHv4jGE44yVFqRN6RSHuUqsRfI2S9D0MZuk1cdSSVnhtVNtNSa4m+5ys
         dpBXSm0w828vafv12GBcblL3kr6SkGqNLwUPszeYkN0u9T9xfyj7Y91WiyG8wnS8/6TD
         FnJUH5KhrUN0gkJ1A6oKwM5ZMq/C/5z7KzKosr3A3TopxFRhbbu+m1cF0obm8snLUA/x
         JZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032732; x=1770637532;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
        b=WM22NYSG7hApoxvgJkHezOsJ+3x8kK9M0ofEIUnRmj/5yvwd1q7POnrskzdPBGtGGP
         qARhVxoiPt6h5ucPBd19oOxRxavgwSDjyQ9IyeLxz6bJH62ZnTaFNnXkKNRvwYr0KAa+
         erFNiY+4b+O9BXdQe7vwypATxZsTVL5idOAYiZjZX672IYtzO54FsG5M8lXEeBv1QbnI
         6yorB6r/+QDdAq51B3Ef3ycuQ3BI8FmjLBm56AGDB2tTX3GxMu8VAaZb1nDkfklZ4Dhg
         Wvf68auDFVjCaybvT/HOBrydqMlT2Zm28Vov7LjqgJwEDIMtjnTfiRvu8KszuxQ0alNR
         mNgw==
X-Gm-Message-State: AOJu0YwKQ/miU/jzQaLccXmxv/U6FaI38PmpYVCyt07RAR3q/2yFJ6k0
	rCPZVQjTNI/RRrjeI3vK+ku7WN2rBkGLPxDGxqL3mfLXzkD4i2WV2Qi0mf/FdxrML2c7yImIDBh
	lYixbGqGg2GwN/bM6h9uGmNU3FTZRnCEPOuvMDIxPfJtgCiGbZphaMhP5yxyzvGnEAx8470orhc
	lQ49NkEO9qL9CRtdvH0m6UxpkB9VjKJoyuVxZ3vq9t4Gw=
X-Gm-Gg: AZuq6aIYd7q8zZ68WoN7OziCdLNQQK/CExMsvq26DHMGOhfRI4dI8/L9S3TaL+9ucI2
	P0qpR88cxqKQBzyq4KhIa1w8tZEXmSFHy65OH57OrSEmXk/Ji2ZHbSnCuTq1ac75zJOWpo4v+73
	yqt1csxYX8ed7u4SXEd+CEb2z/IjbjnN1/Nu2IqxYAcqVMckf4Pydy8LHsRc+Mt9IE1P+VcC93I
	mCx6lcvOerZjh6aSh2AskuyGmnQkeULifBW/N/Dv1cRuTo9TBA5xkv4m0dfoorINoD99PRkRSgd
	ztnMYzmPLn1Gq1Pnk6bu5dqQw0CDxE53EsGmpxcIMB4/9siDYBI2KJPa5H35ePqNzYjx/Idc6IO
	5foGmdJSt
X-Received: by 2002:a05:620a:3191:b0:8c6:a809:862a with SMTP id af79cd13be357-8c9eb2fad23mr1443294685a.45.1770032732448;
        Mon, 02 Feb 2026 03:45:32 -0800 (PST)
X-Received: by 2002:a05:620a:3191:b0:8c6:a809:862a with SMTP id af79cd13be357-8c9eb2fad23mr1443292885a.45.1770032731952;
        Mon, 02 Feb 2026 03:45:31 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894dae83f1fsm99553146d6.38.2026.02.02.03.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 03:45:31 -0800 (PST)
Message-ID: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
Date: Mon, 2 Feb 2026 06:45:30 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.5 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18640-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 943F5CBEA7
X-Rspamd-Action: no action

Hello,

This release contains the following:

     * Man page corrections
     * min-threads parameter added to nfsdctl.
     * systemd updates to rpc-statd-notify.
     * blkmapd not built by default (--enable-blkmapd to re-enable)
     * A number of other bug fixes.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


