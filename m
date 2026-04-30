Return-Path: <linux-nfs+bounces-21318-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKb3BSjK82ma7AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21318-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 23:31:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B28604A8363
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 23:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314B1300DF4C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F783B8BC3;
	Thu, 30 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKvX8KXo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C339E6F8
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584645; cv=none; b=Fjl7aL0E3yKqIQieJPiyB5H6S+3zBG5l6pc/6Usfp4LBF6oWBVx8HEu+GS4CL0sEpLVjJUL7XmvIDD9+l85WGARIGzDTbEVTlFAedHDVfJplTDsvJGs84YzjesgzDyjUZa+WwpkWJU/6CPhDvz3ZM6xkU4C7NSpdUauQIMhzMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584645; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qGylEdWjGXvbaLZxU9J6VYSwiFQbIdnWKWwKWeZoDM/eapuZBEjSaDbreU6B6yALYytOX98Nm1JVUGh8+ijUu9Eghx60MrnviSjh/0Aea11UA4qTemYFRPNqmvngqsAPfXkfKbXk0VL/EvxXdOdYDZGhHGI0Y03daTyEKDd44/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PKvX8KXo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIQE362481069
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6j820-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee34588671so656259eec.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584642; x=1778189442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=PKvX8KXoYGVEMonN2qNRrOp4lZ9McwgkAApHJKA1gvS5pdVJqyANhKAWkFzGi/X/DU
         cOeMIM46UFQofg8ujMuNWY472DUzvT92UwNZYJS4rKnx3N2pVNsWAfkU7tBuzcCwuHDP
         gNRL8yxu1CqniLtBrAvp3C6KF4qrijJ4uZff9brbEpWxPs0RI17t0pFcZlRGCE7KgTNR
         foX1DhZT8ShKRXoG7haVnby4b1EcBmpHUBJ7TQEU2awk29YabQhM3181MVAsxa3Mo0sr
         qfAqtIIAI5tPiTSyM8sYJEmRh4TnhyP1gWUsGQa6pdlKMZHN7s6JlQbjqdWi/b+ysimq
         64cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584642; x=1778189442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=oCmBmDPqJSxVse43ISxhm+lBdqhdQXPeLl1M6jYlxCQN5wDXK6Bdk0yXPd4kHKCt1+
         eWI/OTpJqM9Qg7LdV73THTr/5B5kWYy3gyPXAmc6I24z2WlrQC9Y4Vk6ZnOIWFU+9pUb
         BlGzEmJymK3JOxw1vzitm9vUDCnTFev7a3GM7NKhsA0R+Calh4p5PJ9soZ6SsQTXnhzn
         XG2K0Z/epJJwCLuQSyUEbUlj1gLav1l+u9sd6G8Ex4qQrHi/oeagIUVIHj/jMz1Ytu4J
         vqysAiT7G9M6VTzOmlMN35wDgM7g9wYmwMOuq46Zd4RlnXJUX+s4llB0ckZeRtPzX/wj
         5s+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+4DeuomPXkHAjdVmcNbuVlkIfljzrY4He/jBwWcS+r5yov2ED+UZGNRYgsvK1S+lIFgHu7qBEl+xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Bbz/Q8RE84Bbo5Ti1uBsgt1Qh3Sxh/NSjGhWXonwvXGcq4uC
	LgeldR4N5SImrQdGOgSVl1M2WlEiebmA0ZGS0+LUEWuT2pQ9Hl1CQIrX+QzGpG7nPEwYeM54AC8
	3h54oZ5m0iNWWs+oamJ6jWoskXNMoxhLqPTFL+6tROfqld1Lh5bm1MiNypTmMnbI=
X-Gm-Gg: AeBDietp8sNnL71YnKXZY0YJNVMVOhwuOYJSa2XKBs8nBYxSTMhgyAuHI5dhGH1Icld
	lt6P9dKoPBMqhHx3t81ANRihIBU9CLvedIsRBZzevquycBvAcYKBh5ikqVK8h3IR175en5XVfu7
	md5/Kv1LdnlKjh2Y0LldZmPuEnX7tznPsNKCyIl1dn+iOdmo+XeVm6nD74z5kViB442j4Iy4NkN
	33Cfk7ZioMXnSB4sW2Xj3V6supqiDfPfJqlOgVqHDyToW3T1thOiy/Aun99k4Fl7FXiFMQbazW7
	JD2qD3hOrEzVsE9NzxPd37ighHosrGyH7wuThvqrNY1sQn37f6Z5bh2gZVMHC6iomz0vSYk7+nw
	V0T4RH8i1NwYBndSGL+VB0rcBc1lsyAGUvJvOLWe8Ey+aAw4lZ125qHuOO9UtdliUtZAzeo2km3
	AlZWjz8PjQB1I=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496705eec.8.1777584641138;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: MZ4Rkuvw0YmpKYnKJ8mIrDrmxekwP847
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMSBTYWx0ZWRfX+hZRcuNPVM8D
 M32nc3vt1Sgw51EgOPJ+Byny+EP1uqqdJ8er26VAqVMe9UCox74PCNV3wF8fsnHo0tEbOQeqFhg
 P++aFpLLMtq08hO9sjXlmrrgtRtJkZ4FA1QkpiEGedhqFzNh3PKmij5YEW5ERMVvCKiuEkdsc+1
 swEMdGy8ibdu2qfrjlhq8itCCPmFBg78RiA/xZWrclBqnvXORJqpjcgBm98zlpYnjmcv+kRtl3i
 /pC+iug1C/Cw7rvSR/1LPcgN7YmZ8EiLem/X9c3xgf191xJYN7/dMsSBu6epQC82HW0yJSahgtQ
 Ux7zYJb8p0SC6OJ64bFuVN6H0yOK7i36jtHWzt2Up439gjH2IILD504ubF9vf2dh401OPeM0R5o
 SbyYGVEO2PR31ertiomSS93Hgad22Vd7ldPB52GHm5ZXp9kI/GgrbjwS1Pr7ErJBnOa7d+hJMZm
 OMYLYjQ7PczYXPlZEjg==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f3ca03 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: MZ4Rkuvw0YmpKYnKJ8mIrDrmxekwP847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300221
X-Rspamd-Queue-Id: B28604A8363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21318-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,linux.intel.com,gmail.com,jvosburgh.net,linux.ibm.com,kvack.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,sina.com,kernel.org,vger.kernel.org,lists.linux.dev,kvack.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


