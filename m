Return-Path: <linux-nfs+bounces-21657-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKuwMpxmCmq60wQAu9opvQ
	(envelope-from <linux-nfs+bounces-21657-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 03:08:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4C564AB9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 943533008E2A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACAEACD;
	Mon, 18 May 2026 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b="PctnXuO4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.supcon.com (mail.supcon.com [218.75.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C61F63D9;
	Mon, 18 May 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.75.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066514; cv=none; b=MRCTtvt6v9RunwOfomYrQUvZX+t4RCYwtfwPsBCa5T7Qtch3twSegYk/3TWjsbXDpQ0ggYK2h0pCpV+ft9rFl/f9m0j4WTZBW4duREe7v2nb7U1U0PHNClzfeCGsf9z/084nr85+cw9kX4sE/zQmIiIj9yQkyOFSq58Q3frDbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066514; c=relaxed/simple;
	bh=EOUOUnxlzVhmysZAO6d9pqr+8NuNXLo6gD3gP74R+0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:Content-Type:MIME-Version:
	 Message-ID; b=jhwWmXKogQJpBNC+OjLdMjzMaUC8vxtZfKD02hp+xqPqsa3q4GDDUs2nrFO/nqKxtLx3SzUE4NdlkhB8lsv3avGtZUFD+HBxcrR65ndq+ty+79lRjhDOpTlq1IN7QX5SsWj0CZSWrl9f9zwD+OQCp2iq1LSdMWay7l4cQ5wfqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com; spf=pass smtp.mailfrom=supcon.com; dkim=pass (1024-bit key) header.d=supcon.com header.i=@supcon.com header.b=PctnXuO4; arc=none smtp.client-ip=218.75.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcon.com
Received: from maildata.cn (unknown [10.32.1.145])
	by mail.supcon.com (MailData Gateway V2.8.8) with SMTP id C7044512F25;
	Mon, 18 May 2026 09:06:19 +0800 (CST)
Received: from supcon.com (unknown [10.32.1.229])
	by mdau02 (MailData Audit V3.4.6) with ESMTP id 0FB3520387E04;
	Mon, 18 May 2026 09:06:17 +0800 (CST)
XMD-OLD-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=supcon.com; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=o132uNfc8BoI1o/Cqeo6XxRSH9CY+XZpOZ++
	BeKGiic=; b=Ow3i2VPWz7Y4MG3dP0pYzh0wR7BdhX02kaZh0LaZo5PL+btiFgsM
	FkL+lEUTSOTv0kqqyjJAFvS6v8D6yhFfFW9t3uu65SGem9jmab8FFvrdHVmv9d7m
	r6sXcVNvsyzkbVDKWMEn2eQIZ8OwfLBxkTHtZc3ty87wEaNCArAMeX0=
Received: from guolingxing$supcon.com ( [10.30.28.7] ) by ajax-webmail-app1
 (Coremail) ; Mon, 18 May 2026 09:06:15 +0800 (GMT+08:00)
Date: Mon, 18 May 2026 09:06:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-MD-FileKey: 8aa7461a9a49f3f2afe31b71ad6bf9e2[#]6c46187e5fc6a78a333f104c81a1d084
X-MD-Sfrom: guolingxing@supcon.com
X-MD-SrcIP: 10.32.1.145
From: =?UTF-8?B?6YOt546y5YW0?= <guolingxing@supcon.com>
To: "Rick Macklem" <rick.macklem@gmail.com>
Cc: "Lionel Cons" <lionelcons1972@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [BUG] NFSv4.1 client hang in nfs4_drain_slot_tbl under
 concurrent workload against Windows NFS server
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-27421bd6-c70e-4259-88e7-36dce31e831d-supcon.com
In-Reply-To: <CAM5tNy4A-a4q-t_z7v_sHFW0VeyPLu_yEJ4RQ4DxXVAF-5kROg@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: Vp7Fh2Zvb3Rlcl90eHQ9Mjk4ODoxMA==
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <552f72d1.1c692.19e389e8ea4.Coremail.guolingxing@supcon.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:5QEgCgBnVTYHZgpqEdwdAg--.6541W
X-CM-SenderInfo: xjxrzxpqj0x0nj6v31xfrqhudrp/1tbiAQEKBmoIh3sWBgACsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supcon.com; s=default;
	t=1779066381; bh=EOUOUnxlzVhmysZAO6d9pqr+8NuNXLo6gD3gP74R+0M=;
	h=Date:From:To:Cc:Subject:Content-Type:Message-ID;
	b=PctnXuO4PBo6NK+xY5kGqjrXzJhj6AI8CLSQZymjFHHxuGbx1wVApVJQkpLAZI+Vd
	 DW0OJ2nltRsPx90VLFWD4KFy29inUb3zUTyOzeqwbOjuMuK9b5vuRvvOj0IzMvVczD
	 vXFBivo/jJz5CRHZJniHoqqWsw7eotKkLVPbMZ0o=
X-Rspamd-Queue-Id: D7A4C564AB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[supcon.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21657-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[supcon.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[supcon.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guolingxing@supcon.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,supcon.com:email,supcon.com:mid,supcon.com:dkim]
X-Rspamd-Action: no action

IEhpIFJpY2ssIGhpIExpb25lbAoKQmVsb3cgYXJlIHRoZSBlbnZpcm9ubWVudCBkZXRhaWxzLgoK
U2VydmVyOgogIFdpbmRvd3MgU2VydmVyIDIwMjIKICBWZXJzaW9uIDEwLjAuMjAzNDguNTg3CgpV
c2VyL2FjY291bnQgc2V0dXA6CiAgTm8gdXNlciBtYXBwaW5nIGlzIGNvbmZpZ3VyZWQuCiAgTm8g
QUQsIExEQVAsIG9yIHBhc3N3ZC1iYXNlZCBtYXBwaW5nIGlzIHVzZWQuCiAgVW5tYXBwZWQgdXNl
cnMgYXJlIGhhbmRsZWQgYnkgdGhlIGRlZmF1bHQgIkV2ZXJ5b25lIiBhY2NvdW50LgoKQXV0aGVu
dGljYXRpb246CiAgc2VjPXN5cyAoQVVUSF9TWVMpLCBhcyByZXBvcnRlZCBieSBuZnNzdGF0IC1t
CgpBcmNoaXRlY3R1cmU6CiAgTGludXggY2xpZW50czogeDg2XzY0CiAgV2luZG93cyBzZXJ2ZXI6
IHg4Nl82NAoKTWVtb3J5OgogIEVhY2ggTGludXggY2xpZW50IFZNIGhhcyAxNiBHQiBSQU0KCldl
IGFsc28gb2JzZXJ2ZWQgdGhlIGZvbGxvd2luZyBvbiB0d28gaW5kZXBlbmRlbnQgY2xpZW50czoK
CkNsaWVudCBBOgogIGFnZTogNDk4MDYxCiAgbGVhc2VfdGltZTogMTIwCiAgbGVhc2VfZXhwaXJl
ZDogNDk3OTQxCgpDbGllbnQgQjoKICBhZ2U6IDY5NTk4CiAgbGVhc2VfdGltZTogMTIwCiAgbGVh
c2VfZXhwaXJlZDogNjk0NzgKCkluIGJvdGggY2FzZXMsIGxlYXNlX2V4cGlyZWQgaXMgYXBwcm94
aW1hdGVseSBlcXVhbCB0bwphZ2UgLSBsZWFzZV90aW1lLCB3aGljaCBzdWdnZXN0cyB0aGF0IHRo
ZSBsZWFzZSBleHBpcmVkCnNob3J0bHkgYWZ0ZXIgbW91bnQgYW5kIHdhcyBub3QgcmVuZXdlZCBh
ZnRlcndhcmQuCgpBdCBoYW5nIHRpbWU6CgotIGJvdGggY2xpZW50cyBoYW5nIHVuZGVyIGNvbmN1
cnJlbnQgd29ya2xvYWQKLSBib3RoIGNsaWVudHMgYXJlIGJsb2NrZWQgaW4gbmZzNF9kcmFpbl9z
bG90X3RibAotIG5vIE5GUyBSUEMgdHJhZmZpYyBpcyBvYnNlcnZlZCwgb25seSBUQ1AgQUNLcwot
IG5mc3N0YXQgcmVwb3J0cyByZXRyYW5zPTAKLSBvbiB0aGUgV2luZG93cyBzZXJ2ZXIgc2lkZSwg
dGhlIHNlc3Npb24gc3RhdGUgaXMgcmVwb3J0ZWQKICBhcyAiSW5pdGlhbGl6ZWQiCgpXZSBhcmUg
dHJhY2luZyB0aGUgUlBDIGxpZmVjeWNsZSB0byBpZGVudGlmeSB3aGljaCBSUEMgZG9lcwpub3Qg
Y29tcGxldGUuCgpSZWdhcmRpbmcgdGhlICJzb2Z0IiBtb3VudCBvcHRpb246IHVuZGVyc3Rvb2Qu
IFdlIHdpbGwgcmV0ZXN0CndpdGggYSBoYXJkIG1vdW50IGFzIHdlbGwuCgpPbmUgcXVlc3Rpb24g
aXMgd2hldGhlciB0aGUgb2JzZXJ2ZWQgYmVoYXZpb3IgaXMgZXhwZWN0ZWQuCkV2ZW4gaWYgYSBz
b2Z0IG1vdW50IGNvbnRyaWJ1dGVzIHRvIHRoZSBwcm9ibGVtLCBpcyBpdCBleHBlY3RlZAp0aGF0
IGEgc2luZ2xlIFJQQyB0aW1lb3V0IGNhbiBsZWF2ZSB0aGUgY2xpZW50IGluIGEgc3RhdGUgd2l0
aApubyBmb3J3YXJkIHByb2dyZXNzLCBibG9ja2VkIGluIG5mczRfZHJhaW5fc2xvdF90YmwsIGFu
ZCB3aXRoCmxlYXNlIHJlbmV3YWwgbm8gbG9uZ2VyIG9jY3VycmluZz8gT3Igd291bGQgdGhhdCBt
b3JlIGxpa2VseQppbmRpY2F0ZSBhIGNsaWVudC1zaWRlIHJlY292ZXJ5IGJ1Zz8KCgpUaGFua3Ms
Ckd1byBMaW5neGluZwoKCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujogIlJp
Y2sgTWFja2xlbSIgPHJpY2subWFja2xlbUBnbWFpbC5jb20+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYt
MDUtMTYgMjI6MjM6NTEgKOaYn+acn+WFrSkKPiDmlLbku7bkuro6ICJMaW9uZWwgQ29ucyIgPGxp
b25lbGNvbnMxOTcyQGdtYWlsLmNvbT4KPiDmioTpgIE6IOmDreeOsuWFtCA8Z3VvbGluZ3hpbmdA
c3VwY29uLmNvbT4sIGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKPiDkuLvpopg6IFJlOiBbQlVHXSBORlN2NC4xIGNsaWVudCBoYW5nIGluIG5m
czRfZHJhaW5fc2xvdF90YmwgdW5kZXIgY29uY3VycmVudCB3b3JrbG9hZCBhZ2FpbnN0IFdpbmRv
d3MgTkZTIHNlcnZlcgo+IAo+IE9uIFdlZCwgTWF5IDYsIDIwMjYgYXQgNjozMuKAr0FNIExpb25l
bCBDb25zIDxsaW9uZWxjb25zMTk3MkBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwg
NiBNYXkgMjAyNiBhdCAwOTo0OSwg6YOt546y5YW0IDxndW9saW5neGluZ0BzdXBjb24uY29tPiB3
cm90ZToKPiA+ID4KPiA+ID4gSGksCj4gPiA+Cj4gPiA+Cj4gPiA+IFdlIGVuY291bnRlcmVkIGEg
cmVwcm9kdWNpYmxlIE5GU3Y0LjEgY2xpZW50IGhhbmcgaXNzdWUgdW5kZXIgY29uY3VycmVudCB3
b3JrbG9hZC4KPiA+ID4KPiA+ID4KPiA+ID4gRW52aXJvbm1lbnQ6Cj4gPiA+IC0gVHdvIGluZGVw
ZW5kZW50IExpbnV4IGNsaWVudHMgKFZNcykKPiA+ID4gLSBCb3RoIG1vdW50IHRoZSBzYW1lIFdp
bmRvd3MgTkZTIHNlcnZlciAoTkZTdjQuMSkKPiA+ID4gLSBLZXJuZWwgdmVyc2lvbjogNi4xLjc4
Cj4gPiA+IC0gTW91bnQgb3B0aW9uczogdmVycz00LjEsc29mdCxwcm90bz10Y3AsdGltZW89NjAs
cmV0cmFucz0xMAo+IEp1c3QgZnlpLCAic29mdCIgbW91bnRzIGFyZSBvZnRlbiBnb2luZyB0byBi
ZSB0cm91Ymxlc29tZSBmb3IgTkZTdjQuMS4KPiAoV2hlbmV2ZXIgYW4gUlBDIHRpbWVzIG91dCBh
bmQgZG9lc24ndCB3YWl0IGZvciBhIHJlcGx5IGZyb20gdGhlIHNlcnZlciwKPiBpdCB3aWxsIGxl
YXZlIGEgc2Vzc2lvbiBzbG90IG1lc3NlZCB1cC4pCj4gCj4gcmljawo+IAo+ID4KPiA+IFdoaWNo
IHZlcnNpb24gb2YgV2luZG93c1NlcnZlciBkbyB5b3UgdXNlLCBlLmcgd2hhdCBkb2VzIHRoZSAi
dmVyIgo+ID4gY29tbWFuZCBpbiBjbWQuZXhlIG91dHB1dD8gSG93IGRpZCB5b3Ugc2V0IHVwIHRo
ZSB1c2VyIGFjY291bnRzLCBhbmQKPiA+IHdoaWNoIGF1dGhlbnRpY2F0aW9uIChBVVRIX1NZUywg
R1NTLCAuLi4pIGRvIHlvdSB1c2U/Cj4gPiBXaGljaCBDUFUgYXJjaGl0ZWN0dXJlIGRvIHlvdSB1
c2U/IEhvdyBtdWNoIG1lbW9yeSBkbyB5b3UgaGF2ZSBvbiB0aGUKPiA+IExpbnV4IE5GUyBjbGll
bnQ/Cj4gPgo+ID4gTGlvbmVsCj4gPgoNCg0KDQoNCg0K

