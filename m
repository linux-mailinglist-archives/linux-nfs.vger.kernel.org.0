Return-Path: <linux-nfs+bounces-20491-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q6vIGpHLx2mAcgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20491-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 13:37:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F278134E6BE
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 13:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CA423012B6C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8F3876CD;
	Sat, 28 Mar 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioikTdPK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD837F729;
	Sat, 28 Mar 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774701454; cv=none; b=EDiJrUsCLY6FqEDfiNRlGmkl6+TRqfHgyHZVH2oLXxYoraYVLg6vjzuFfnLdkR9kCODpvP9Aiw5b/ZRVqj1LWHci0WKXBaVdxUkiOAmbZYx0doJIOAc34VsjzoOmdd395Kii9CzO9ZRU2/QWK4bFlHmCN6UAyQ5A2Sl+YeSWve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774701454; c=relaxed/simple;
	bh=w72L3OoLIOlgeVuzat4EAHj9xhm7zFzKaNJwSXyC0b8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofxrg3vjp83iQhh+2l2/MHGVLhDrD4PQJpg4zFXlqWNAYmo74OQDAf8FvNOmlergvmbCq8Z2g7DeqRWZWUd6CRNcNMb6nGcywOlNu4dotRztJSm02S7X0EQfUIef5lpPGzq4yExXZpnkdfdEBPEsXscPz6T0jP4v0zQ5LI1Cq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioikTdPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A352C4CEF7;
	Sat, 28 Mar 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774701453;
	bh=w72L3OoLIOlgeVuzat4EAHj9xhm7zFzKaNJwSXyC0b8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ioikTdPK8urde7oQmAaXDAAeaKKwnX3L1NLw9eE0g3qT9PLJB9hLPo628J0cTowFN
	 Fh+IpYxlKz8BJQdnil6HkjsBu/P6qcln6s8kJjbD61ovmEg2bqe3A1vrGV5Zmg6LW8
	 bdzwcFUTMdwKdNBRgMXxfkwEEyOoTMzXBZhKvns2WEI+QUS8cSZD/AaErQb/jiy0xi
	 6aLRH3TNlewQHUOfGFfM43vvG+Ilt2XAZdsxqOeIS3PCih7OFma8OWOGgDM1L4UiAm
	 XIBQbo9kpHcDi8YT8hnTfZ2kXocjiMJCiH65yMqC7BLtH0G0VVk6CbTaMNpn1H1JBH
	 V5tBANPsXIXxg==
Message-ID: <cf3aba50556defa87ecbb38ba1af045ef3bc9fee.camel@kernel.org>
Subject: Re: A comparison of the new nfsd iomodes (and an experimental one)
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	jonathan.flynn@hammerspace.com
Date: Sat, 28 Mar 2026 08:37:30 -0400
In-Reply-To: <aca3ApIPUGAovh_7@kernel.org>
References: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
	 <d453add6-ed23-4d61-af95-d80133b0e456@oracle.com>
	 <33582a86daf135336f6bc0d5260d8de0501abadd.camel@kernel.org>
	 <acWbrlvt_dUB9X3R@kernel.org>
	 <70e9c23a97d94a3dad5aa7f03f5a22c0950b00bf.camel@kernel.org>
	 <43921656-e0c3-4b55-ad1f-4965ff40f1f4@oracle.com>
	 <aca3ApIPUGAovh_7@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-HgVGRAm/4T5zG2v0Yv2K"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20491-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F278134E6BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--=-HgVGRAm/4T5zG2v0Yv2K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-27 at 12:57 -0400, Mike Snitzer wrote:
> On Fri, Mar 27, 2026 at 09:19:07AM -0400, Chuck Lever wrote:
> > On 3/27/26 7:32 AM, Jeff Layton wrote:
> > > On Thu, 2026-03-26 at 16:48 -0400, Mike Snitzer wrote:
> > >=20
> > > > Your bandwidth for 1MB sequential IO of 793 MB/s for O_DIRECT and
> > > > 4,952 MB/s for buffered and dontcache is considerably less than the=
 72
> > > > GB/s offered in Jon's testbed.  Your testing isn't exposing the
> > > > bottlenecks (contention) of the MM subsystem for buffered IO... not
> > > > yet put my finger on _why_ that is.
> > >=20
> > > That may very well be, but not everyone has a box as large as the one
> > > you and Jon were working with.
> >=20
> > Right, and this is kind of a blocker for us. Practically speaking, Jon'=
s
> > results are not reproducible.
> >=20
> > It would be immensely helpful if the MM-tipover behavior could be
> > reproduced on smaller systems. Reduced physical memory size, lower
> > network and storage speed, and so on, so that Jeff and I can study the
> > issue on our own systems.
>=20
> Hammerspace still has the same performance lab setup, so we can
> certainly reproduce if needed (and try to scale it down, etc) but
> unfortunately its currently tied up with other important work. Jon
> Flynn's testing was "only" with 2 systems (the NFS server has 16 fast
> NVMe, client system connecting over 400 GbE with RDMA). But I'll see
> about shaking a couple systems loose...
>=20
> Might be useful for us to document the setup of the NFS server side
> and give pointers for how to mount from the client system and then run
> fio commandline.
>=20
> I think Jens has a couple beefy servers with lots of fast NVMe. Maybe
> he'd be open to testing NFS server scalability when he isn't touring
> around the country watching his kid win motorsports events.. JENS!? ;)
>=20
>=20

I'm not sure we really even need NFS in the mix to show this. Here's
the results from testing them both on local XFS (same host in this
case, just no NFS in the mix):

    https://text.is/VN0K3

tl;dr: DONTCACHE_LAZY seems to be better than DONTCACHE across the
board, and it even seems to slightly edge out O_DIRECT for writes.
YMMV on your hw, of course.

The attached patch is what I'm planning to propose, if you want to give
it a spin. I'm testing one more optimization now, to see if I can get
the flush contention down even more.

Personally, I wonder if we ought to consider a proportional flush like
this in the normal buffered write codepath too. I've long thought that
we wait too long to kick off writeback: the flusher threads have a 5s
duty cycle, and all of our dirty writeback percentages were last set
when RAM sizes were much smaller.

Doing something like this in the normal buffered case might allow us to
get ahead of heavy writers easier.
--=20
Jeff Layton <jlayton@kernel.org>

--=-HgVGRAm/4T5zG2v0Yv2K
Content-Disposition: attachment;
	filename*0=0001-mm-fix-IOCB_DONTCACHE-write-performance-with-rate-li.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-mm-fix-IOCB_DONTCACHE-write-performance-with-rate-li.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAxNGE2MDA2NDM2NTkxOGIzOGU4NzcwODRkOTRmM2EyZmE0ZDBiNzQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpEYXRl
OiBTYXQsIDI4IE1hciAyMDI2IDA1OjE0OjE3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gbW06IGZp
eCBJT0NCX0RPTlRDQUNIRSB3cml0ZSBwZXJmb3JtYW5jZSB3aXRoIHJhdGUtbGltaXRlZAogd3Jp
dGViYWNrCgpJT0NCX0RPTlRDQUNIRSBjYWxscyBmaWxlbWFwX2ZsdXNoX3JhbmdlKCkgd2l0aCBu
cl90b193cml0ZT1MT05HX01BWApvbiBldmVyeSB3cml0ZSwgd2hpY2ggZmx1c2hlcyBhbGwgZGly
dHkgcGFnZXMgaW4gdGhlIHdyaXR0ZW4gcmFuZ2UuClVuZGVyIGNvbmN1cnJlbnQgd3JpdGVycyB0
aGlzIGNyZWF0ZXMgc2V2ZXJlIHNlcmlhbGl6YXRpb24gb24gdGhlCndyaXRlYmFjayBzdWJtaXNz
aW9uIHBhdGgsIGNhdXNpbmcgdGhyb3VnaHB1dCB0byBjb2xsYXBzZSB0byB+NDclIG9mCmJ1ZmZl
cmVkIEkvTyB3aXRoIG11bHRpLXNlY29uZCB0YWlsIGxhdGVuY3kuICBFdmVuIHNpbmdsZS1jbGll
bnQKc2VxdWVudGlhbCB3cml0ZXMgc3VmZmVyOiBvbiBhIDUxMkdCIGZpbGUgd2l0aCAyNTZHQiBS
QU0sIHRoZQphZ2dyZXNzaXZlIGZsdXNoaW5nIHRyaWdnZXJzIGRpcnR5IHRocm90dGxpbmcgdGhh
dCBsaW1pdHMgdGhyb3VnaHB1dAp0byA1NzUgTUIvcyB2cyAxNDQyIE1CL3Mgd2l0aCByYXRlLWxp
bWl0ZWQgd3JpdGViYWNrLgoKUmVwbGFjZSB0aGUgZmlsZW1hcF9mbHVzaF9yYW5nZSgpIGNhbGwg
aW4gZ2VuZXJpY193cml0ZV9zeW5jKCkgd2l0aCBhCm5ldyBmaWxlbWFwX2RvbnRjYWNoZV93cml0
ZWJhY2tfcmFuZ2UoKSB0aGF0IHVzZXMgdHdvIHJhdGUtbGltaXRpbmcKbWVjaGFuaXNtczoKCiAg
MS4gU2tpcC1pZi1idXN5OiBjaGVjayBtYXBwaW5nX3RhZ2dlZChQQUdFQ0FDSEVfVEFHX1dSSVRF
QkFDSykKICAgICBiZWZvcmUgZmx1c2hpbmcuICBJZiB3cml0ZWJhY2sgaXMgYWxyZWFkeSBpbiBw
cm9ncmVzcyBvbiB0aGUKICAgICBtYXBwaW5nLCBza2lwIHRoZSBmbHVzaCBlbnRpcmVseS4gIFRo
aXMgZWxpbWluYXRlcyB3cml0ZWJhY2sKICAgICBzdWJtaXNzaW9uIGNvbnRlbnRpb24gYmV0d2Vl
biBjb25jdXJyZW50IHdyaXRlcnMuCgogIDIuIFByb3BvcnRpb25hbCBjYXA6IHdoZW4gZmx1c2hp
bmcgZG9lcyBvY2N1ciwgY2FwIG5yX3RvX3dyaXRlIHRvCiAgICAgdGhlIG51bWJlciBvZiBwYWdl
cyBqdXN0IHdyaXR0ZW4uICBUaGlzIHByZXZlbnRzIGFueSBzaW5nbGUKICAgICB3cml0ZSBmcm9t
IHRyaWdnZXJpbmcgYSBsYXJnZSBmbHVzaCB0aGF0IHdvdWxkIHN0YXJ2ZSBjb25jdXJyZW50CiAg
ICAgcmVhZGVycy4KCkJvdGggbWVjaGFuaXNtcyBhcmUgbmVjZXNzYXJ5OiBza2lwLWlmLWJ1c3kg
YWxvbmUgY2F1c2VzIEkvTyBidXJzdHMKd2hlbiB0aGUgdGFnIGNsZWFycyAocmVhZGVyIHA5OS45
IHNwaWtlcyA4M3gpOyBwcm9wb3J0aW9uYWwgY2FwIGFsb25lCnN0aWxsIHNlcmlhbGl6ZXMgb24g
eGFycmF5IGxvY2tzIHJlZ2FyZGxlc3Mgb2Ygc3VibWlzc2lvbiBzaXplLgoKUGFnZXMgdG91Y2hl
ZCB1bmRlciBJT0NCX0RPTlRDQUNIRSBjb250aW51ZSB0byBiZSBtYXJrZWQgZm9yIGV2aWN0aW9u
Cihkcm9wYmVoaW5kKSwgc28gcGFnZSBjYWNoZSB1c2FnZSByZW1haW5zIGJvdW5kZWQuICBSYW5n
ZXMgc2tpcHBlZCBieQp0aGUgYnVzeSBjaGVjayBhcmUgZXZlbnR1YWxseSBmbHVzaGVkIGJ5IGJh
Y2tncm91bmQgd3JpdGViYWNrIG9yIGJ5CnRoZSBuZXh0IHdyaXRlciB0byBmaW5kIHRoZSB0YWcg
Y2xlYXIuCgpTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgot
LS0KIGluY2x1ZGUvbGludXgvZnMuaCB8ICA3ICsrKysrLS0KIG1tL2ZpbGVtYXAuYyAgICAgICB8
IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9m
cy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCmluZGV4IDk0Njk1Y2U1ZTI1YjUuLmI2MGJjZjMwZDYy
ZTcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Zz
LmgKQEAgLTI1ODksNiArMjU4OSw4IEBAIGV4dGVybiBpbnQgX19tdXN0X2NoZWNrIGZpbGVfd3Jp
dGVfYW5kX3dhaXRfcmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGUsCiAJCQkJCQlsb2ZmX3Qgc3RhcnQs
IGxvZmZfdCBlbmQpOwogaW50IGZpbGVtYXBfZmx1c2hfcmFuZ2Uoc3RydWN0IGFkZHJlc3Nfc3Bh
Y2UgKm1hcHBpbmcsIGxvZmZfdCBzdGFydCwKIAkJbG9mZl90IGVuZCk7CitpbnQgZmlsZW1hcF9k
b250Y2FjaGVfd3JpdGViYWNrX3JhbmdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAor
CQlsb2ZmX3Qgc3RhcnQsIGxvZmZfdCBlbmQsIHNzaXplX3QgbnJfd3JpdHRlbik7CiAKIHN0YXRp
YyBpbmxpbmUgaW50IGZpbGVfd3JpdGVfYW5kX3dhaXQoc3RydWN0IGZpbGUgKmZpbGUpCiB7CkBA
IC0yNjI0LDggKzI2MjYsOSBAQCBzdGF0aWMgaW5saW5lIHNzaXplX3QgZ2VuZXJpY193cml0ZV9z
eW5jKHN0cnVjdCBraW9jYiAqaW9jYiwgc3NpemVfdCBjb3VudCkKIAl9IGVsc2UgaWYgKGlvY2It
PmtpX2ZsYWdzICYgSU9DQl9ET05UQ0FDSEUpIHsKIAkJc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1h
cHBpbmcgPSBpb2NiLT5raV9maWxwLT5mX21hcHBpbmc7CiAKLQkJZmlsZW1hcF9mbHVzaF9yYW5n
ZShtYXBwaW5nLCBpb2NiLT5raV9wb3MgLSBjb3VudCwKLQkJCQlpb2NiLT5raV9wb3MgLSAxKTsK
KwkJZmlsZW1hcF9kb250Y2FjaGVfd3JpdGViYWNrX3JhbmdlKG1hcHBpbmcsCisJCQkJaW9jYi0+
a2lfcG9zIC0gY291bnQsCisJCQkJaW9jYi0+a2lfcG9zIC0gMSwgY291bnQpOwogCX0KIAogCXJl
dHVybiBjb3VudDsKZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRl
eCA5Njk3ZTEyZGZiZGNjLi5lZDM5MmQ3ODFjNDMzIDEwMDY0NAotLS0gYS9tbS9maWxlbWFwLmMK
KysrIGIvbW0vZmlsZW1hcC5jCkBAIC00NDAsNiArNDQwLDM1IEBAIGludCBmaWxlbWFwX2ZsdXNo
X3JhbmdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBsb2ZmX3Qgc3RhcnQsCiB9CiBF
WFBPUlRfU1lNQk9MX0dQTChmaWxlbWFwX2ZsdXNoX3JhbmdlKTsKIAorLyoqCisgKiBmaWxlbWFw
X2RvbnRjYWNoZV93cml0ZWJhY2tfcmFuZ2UgLSByYXRlLWxpbWl0ZWQgd3JpdGViYWNrIGZvciBk
b250Y2FjaGUgSS9PCisgKiBAbWFwcGluZzoJdGFyZ2V0IGFkZHJlc3Nfc3BhY2UKKyAqIEBzdGFy
dDoJYnl0ZSBvZmZzZXQgdG8gc3RhcnQgd3JpdGViYWNrCisgKiBAZW5kOglsYXN0IGJ5dGUgb2Zm
c2V0IChpbmNsdXNpdmUpIGZvciB3cml0ZWJhY2sKKyAqIEBucl93cml0dGVuOgludW1iZXIgb2Yg
Ynl0ZXMganVzdCB3cml0dGVuIGJ5IHRoZSBjYWxsZXIKKyAqCisgKiBSYXRlLWxpbWl0ZWQgd3Jp
dGViYWNrIGZvciBJT0NCX0RPTlRDQUNIRSB3cml0ZXMuICBTa2lwcyB0aGUgZmx1c2gKKyAqIGVu
dGlyZWx5IGlmIHdyaXRlYmFjayBpcyBhbHJlYWR5IGluIHByb2dyZXNzIG9uIHRoZSBtYXBwaW5n
IChza2lwLWlmLWJ1c3kpLAorICogYW5kIHdoZW4gZmx1c2hpbmcsIGNhcHMgbnJfdG9fd3JpdGUg
dG8gdGhlIG51bWJlciBvZiBwYWdlcyBqdXN0IHdyaXR0ZW4KKyAqIChwcm9wb3J0aW9uYWwgY2Fw
KS4gIFRvZ2V0aGVyIHRoZXNlIGF2b2lkIHdyaXRlYmFjayBjb250ZW50aW9uIGJldHdlZW4KKyAq
IGNvbmN1cnJlbnQgd3JpdGVycyBhbmQgcHJldmVudCBJL08gYnVyc3RzIHRoYXQgc3RhcnZlIHJl
YWRlcnMuCisgKgorICogUmV0dXJuOiAlMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2Rl
IG90aGVyd2lzZS4KKyAqLworaW50IGZpbGVtYXBfZG9udGNhY2hlX3dyaXRlYmFja19yYW5nZShz
dHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKKwkJbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5k
LCBzc2l6ZV90IG5yX3dyaXR0ZW4pCit7CisJbG9uZyBucjsKKworCWlmIChtYXBwaW5nX3RhZ2dl
ZChtYXBwaW5nLCBQQUdFQ0FDSEVfVEFHX1dSSVRFQkFDSykpCisJCXJldHVybiAwOworCisJbnIg
PSAobnJfd3JpdHRlbiArIFBBR0VfU0laRSAtIDEpID4+IFBBR0VfU0hJRlQ7CisJcmV0dXJuIGZp
bGVtYXBfd3JpdGViYWNrKG1hcHBpbmcsIHN0YXJ0LCBlbmQsIFdCX1NZTkNfTk9ORSwgJm5yLAor
CQkJV0JfUkVBU09OX0JBQ0tHUk9VTkQpOworfQorRVhQT1JUX1NZTUJPTF9HUEwoZmlsZW1hcF9k
b250Y2FjaGVfd3JpdGViYWNrX3JhbmdlKTsKKwogLyoqCiAgKiBmaWxlbWFwX2ZsdXNoIC0gbW9z
dGx5IGEgbm9uLWJsb2NraW5nIGZsdXNoCiAgKiBAbWFwcGluZzoJdGFyZ2V0IGFkZHJlc3Nfc3Bh
Y2UKLS0gCjIuNTIuMAoK


--=-HgVGRAm/4T5zG2v0Yv2K--

