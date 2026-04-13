Return-Path: <linux-nfs+bounces-20820-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONiBLFQi3Wn9aAkAu9opvQ
	(envelope-from <linux-nfs+bounces-20820-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 19:05:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325093F0B10
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41003155038
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B329BD87;
	Mon, 13 Apr 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="nSFyUaAu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F6226D18
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097896; cv=none; b=LlyK/VI88De5IeSIZ4Ogh5EPlk4wpkbnzH3kmHxFmb/Vv/u9Oa2+8fPlwUVpPZ6sYOVYwjicC1yXEMaGRY8VfIypCeL8hi3kQZal4zk3PSlaMvve9iQANzqmZOw8S+9pZNVUqU3IKozny/ACrHqRq9bVBva9IBGRCQq6gn8kISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097896; c=relaxed/simple;
	bh=hQfG6SYx+ZUfLyajbzaDlE/6qaj8PkruXOeBBmzZvDs=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ruTP0l21CLsID6cbNzCWls+wu9am70PNb3rxaXF/qgIpUCPYy3lXEboy5qMQ8YSICI3jfjzQR8foaPRpi2zkubSdSISaXOPU7xpkeJMNaan3iJ27KnqpPuBgLESGgzavuCgE+t2Ftp2kPbcFoaF3l6e2Uukachp1J4/MatiyGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=nSFyUaAu; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 29CF211F85E
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:56 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 3D79211F744
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 3D79211F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1776097428; bh=PkMvjaZuoHYIZRPOX0CAZQ9UmydQLNTQhSYRc4xxnVw=;
	h=Date:From:To:Subject:From;
	b=nSFyUaAuRW8MlY2QMBvX5Uac/nE/BeVTyOO9BIqjGM7joFhC9hj6U8YDc6uOXeRpQ
	 weMb33LZZ3H6xhAYUW/5ZEe7wbfBprURIlxS+lXpbnSK6zaJaLU60ciNloF9fWLqL7
	 WYqZN2Zk8e9dEDBwdquO9vXeSgXWg5YlFFOq4bsc=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 33D03120043
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:48 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 2CBEF160039
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:48 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 91FDA320093
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:47 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 7834A1A0041
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:23:47 +0200 (CEST)
Date: Mon, 13 Apr 2026 18:23:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1124862647.26550419.1776097427415.JavaMail.zimbra@desy.de>
Subject: NFS client tracepoint confusion
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_26550420_1623596290.1776097427430"
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - FF149 (Linux)/10.1.16_GA_4863)
Thread-Index: oP4hL16LobhoY/IUWiEJ0p3fnXwR9A==
Thread-Topic: NFS client tracepoint confusion
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[desy.de:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20820-lists,linux-nfs=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,desy.de:dkim,desy.de:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 325093F0B10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------=_Part_26550420_1623596290.1776097427430
Date: Mon, 13 Apr 2026 18:23:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1124862647.26550419.1776097427415.JavaMail.zimbra@desy.de>
Subject: NFS client tracepoint confusion
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - FF149 (Linux)/10.1.16_GA_4863)
Thread-Index: oP4hL16LobhoY/IUWiEJ0p3fnXwR9A==
Thread-Topic: NFS client tracepoint confusion


Dear NFS folk,


I am tracing one of our apps and want to match the correlation between application-level open/read/close and NFS-level open/read/close calls.
Here is a fio run that simulates one of our workloads:

fio --name bpftest --rw=randread --size=128k --bs=128k --filename=sample.h5 --loops=123 --openfiles=1 --output=/dev/null

As server issues delegation, I expect that I will see ~123 openat/pread64/close syscalls, ~123 nfs_reads, 1-2 nfs opens, and 1-2 nfs closes.
(The number of sys syscalls is a little bit polluted by open and read of shared libraries.

However, I see a different picture when I run bpftrace


bpftrace  -e 'tracepoint:nfs4:nfs4_pnfs_read,
      tracepoint:syscalls:sys_enter_openat,
      tracepoint:nfs4:nfs4_open_file,
      tracepoint:nfs4:nfs4_close,
      tracepoint:syscalls:
      sys_enter_pread64 /comm == "fio" || strncmp(comm,"kworker", 6) == 0 / { @[comm,probe] = count(); }' 
      -c "fio --name bpftest --rw=randread --size=128k --bs=128k --filename=sample.h5 --loops=123 --openfiles=1 --output=/dev/null"

...


@[kworker/u58:2, tracepoint:nfs4:nfs4_close]: 1
@[kworker/u57:12, tracepoint:nfs4:nfs4_pnfs_read]: 1
@[kworker/u57:3, tracepoint:nfs4:nfs4_pnfs_read]: 57
@[kworker/u57:10, tracepoint:nfs4:nfs4_pnfs_read]: 65
@[fio, tracepoint:nfs4:nfs4_open_file]: 123
@[fio, tracepoint:syscalls:sys_enter_pread64]: 125
@[fio, tracepoint:syscalls:sys_enter_openat]: 202

The number os syscall are as expected as well as the number of nfs4_pnfs_read. However, the number of nfs4_open_file and nfs4_close makes no sense to me.
BTW, the network traffic shows the expected behavior: OPEN+LAYOUTGET -> READ -> CLOSE; OPEN+LAYOUTGET (delegation); READ
Thus, to me, it looks like the trace_nfs4_open_file misses the delegation and is fired, even if no OPEN requests are sent over the network. However, if
trace_nfs4_open_file is in sync with the application-level openat syscall, then it should match the trace_nfs4_close.


I hope I am doing something wrong or looking at the wrong events. Any clarification appreciated.


Thanks in advance,
   Tigran.



------=_Part_26550420_1623596290.1776097427430
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
2zCCBEOgAwIBAgIQBBL/+bEcDC3Q01JGn3M5ITANBgkqhkiG9w0BAQsFADBUMQswCQYDVQQGEwJO
TDEZMBcGA1UECgwQR0VBTlQgVmVyZW5pZ2luZzEqMCgGA1UEAwwhR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA1MB4XDTI1MTIxMjE0MDk0MloXDTI3MDExMTE0MDk0MVowgakxEzARBgoJ
kiaJk/IsZAEZFgNvcmcxFjAUBgoJkiaJk/IsZAEZFgZ0ZXJlbmExEzARBgoJkiaJk/IsZAEZFgN0
Y3MxCzAJBgNVBAYTAkRFMS4wLAYDVQQKDCVEZXV0c2NoZXMgRWxla3Ryb25lbi1TeW5jaHJvdHJv
biBERVNZMSgwJgYDVQQDDB9UaWdyYW4gTWtydGNoeWFuIHRpZ3JhbkBkZXN5LmRlMIIBojANBgkq
hkiG9w0BAQEFAAOCAY8AMIIBigKCAYEArfnI6mD8MyGhRXT544OuIOATR0q0ViKjZWMjNO0PYJ7b
WrA2ahLCMyOw18kaAhArvmyhASlCZGHAeHjMPQAcRWoBQyLXkbusXBqxPQbApGXcXERNGXja00Xk
MrZCGe198EcRgn52hDbmcOhQPlyY/fKp3ukpPDLyQEeZFDDz4KeKFrZ6Qc3ps/yZqjQ2bXY8l93W
G+0DVbP6e2AM0DW4fWDYoafLvnMyl2J5yhYjYXtFkcV7iiDUuQH/lZvYvRQTzlir0jczribIPpss
zxcctqleZRX646qBT+lI0nP+EgdGPCXNteJGbwGHw7DQqXDk+0AIYShiiTMayRODX65uCwRG9iO5
mtibWMeFTzGOy8HG09PFlc8VG8+2pZtIYLPIof65dykviDm0vI0A36iaw7gI5RRy1K6dGpJscKU2
V5d+LlhVu5qjBayUfJQhy4jykZplaeXvQThZ9rg9ngz+FwlEz7tlM5U1hepzD7s1snyVaOGtRiQt
yWSUKcMB0DPJAgMBAAGjggFRMIIBTTAfBgNVHSMEGDAWgBSDrT4rvBOJjYgJHL8g3F+4MVXq8TBX
BggrBgEFBQcBAQRLMEkwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jcnQuZ2VhbnQtcHJ2LmhhcmljYS5n
ci9HRUFOVC1UQ1MtQ2xpZW50LUF1dGgtUjUuY2VyMDUGA1UdIAQuMCwwDAYKKoZIhvdMBQICBTAN
BgsqhkiG90wFAgMDAzANBgsqhkiG90wFAgMBAjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5nZWFudC1wcnYuaGFyaWNhLmdyL0dFQU5U
LVRDUy1DbGllbnQtQXV0aC1SNS5jcmwwHQYDVR0OBBYEFDxIMH6YFtPoOHuwqAzVWAjUq9klMA4G
A1UdDwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAYEAM3+V2E77QHQaDQSi0RRpdct0OrebGrBQ
1UZHmxhwyy1LaTERW/8J70lDP9FxYJlk77whB853mwW/LukNXzRNW/mgpuIlVQH+uooys5NbIgl2
zVuIhQ/7CWO3xYbKyxk8pUwvk43qR/hVprL0djOGm9Wr31AmryK9KMXpod95pv3hydpAPZi+4Kux
GtsmX69ggbcB518och4jij+KCtGCaFHjLbek40VYwAjIRSfwpVTKgFefkTEo+/G9KiJiT3p8Z/RL
6VDc+pB+GFNAW/+Z6nAkRWJKZFrVAEFqX2by2v+CTu9oLPUKiRTCEuSXCqwsMO40qzYT8Tjp9+sq
KfeGDPzRxd/J4G6JSsLpRrCesQnKRTwqEF6yUfvNyrqKe9fImt/UriOFjXcdPqAkhFWIr0d/fZQp
1upqYQ1PnuyfdOU4Ct6NN9PGopyB4i+iKWaECe4W4iPZsF+qWUmynQpbAwDu/UvBN3U4wdrDdeO6
XZ3HQ0q/aG67FOeLCkhOgnvqAAAxggLkMIIC4AIBATBoMFQxCzAJBgNVBAYTAk5MMRkwFwYDVQQK
DBBHRUFOVCBWZXJlbmlnaW5nMSowKAYDVQQDDCFHRUFOVCBUQ1MgQXV0aGVudGljYXRpb24gUlNB
IENBIDUCEAQS//mxHAwt0NNSRp9zOSEwDQYJYIZIAWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNDEzMTYyMzQ3WjAtBgkqhkiG9w0BCTQxIDAe
MA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCAI0snkPq8afbwn
nepuT1qFiUxFdct+9FiEwjebHA9dpzA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0BAQsFAASCAYBrH39nhRuECA20GC94XJeRquUl
4d2/y7wnShPFUa/uoUvgRCqWequ9yF7PROWgyN/XlEoAql4ZkDgmeu3tkjegxAvZclUzrSo1+5Dd
zVJRUShbO7bvu7Az6YisAjmDItrgGPR6alJsBCKNVnVYyTtFRbi9EM3syQp8enGLp9rhulIIOXh6
UovVZ5nISg0gxAY/TA4CGUK4nBQf5g0iN0YKgC/bkNfyGLNOKs3esz1xx2r/gJuPLlAEuSECPPP/
hz7bzM0D2XfNP7BxDmNOAUIq6aKHZGTU+bofaIDMGVyM69YeRx4pQVEKdB4Zbw3u952cyTaYf9e2
W5xLxIovBy7LBg20WUTgCHtT2MlLwLpK3cm7wawXAW9hifOONyXln/ZVXURBafQvsaV3T0v4riC8
fZbyiI4uUHRWvvLRvPDU5P+8E8OMGDVxELf9nKCp0kWvNiPK+4SInkfpLfNj5YIOS4ol9aTD1XsZ
OQ//rbfwdQqbnyaHpbG5cBhb7W4V+0cAAAAAAAA=
------=_Part_26550420_1623596290.1776097427430--

