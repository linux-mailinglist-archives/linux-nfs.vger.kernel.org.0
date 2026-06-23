Return-Path: <linux-nfs+bounces-22782-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bIMVKHRqOmo68gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22782-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:13:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB86A6B69A4
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=desy.de header.s=default header.b=Rhqsfktd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22782-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22782-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=desy.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACADE302FB79
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267F34404A;
	Tue, 23 Jun 2026 11:13:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AE377004
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 11:13:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213233; cv=none; b=UvxInNB6PsPHMNupflOylNuXnef1cOg58U2w9bo3pLzuF3ywK86JWTpgJ8+K5u1vm1Ug8y7rDmFbmwyoiW5sojIclluxzH6Zdd/oJQ/6bHMVIabQx9zp9ZBt1wqP2WDUo+GQWYN39oMps8KwUW42wgOsLmLYDU0gwOhallVVdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213233; c=relaxed/simple;
	bh=S3/c8EsALvFJRvcrw3YjTFvHmIcGLVDrL2IbiTKgtPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cqF78gQai8mAZv2SxmK6aaV+1wGwp4YxkCyHq/J1xhrmFaU3wtD9UDZ/PMlalS706L852Xq4IekcAYLfGfm6u3lIZxIvwnBmlmE1q1AXdIA6wcqo9o0F1AWUlMRbj7Kd3YqqMR2RZ6cWxTEI1bwrn4eX8PunIqlZ75kkU0aOeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=Rhqsfktd; arc=none smtp.client-ip=131.169.56.156
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 1B56111F93F
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:04:41 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id C13C211F744
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:04:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de C13C211F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1782212672; bh=l5t6D/I9k2LRhsmrxmEcssRSKSvSMWNMYA1mbo/53Hc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RhqsfktdoxEZ+/rkbc+Qyj5k2/ylDYO2qn5tu5FdXiEtHR0WMZD30+wFjHpWaL9h3
	 12vvdzV2lYup5hrvCteBqAT4dTGOlkd1I93nKah4atu7lQQnQzr+tHq/tAb4kHMwhK
	 jouQ4JY67Cv9Znd02icVz0WHoiJxXowl5VCxUjnQ=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id B3F7812012E;
	Tue, 23 Jun 2026 13:04:32 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id A559E160039;
	Tue, 23 Jun 2026 13:04:32 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id AD1EC160059;
	Tue, 23 Jun 2026 13:04:31 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 92CDF1A0041;
	Tue, 23 Jun 2026 13:04:31 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:04:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Piyush Sachdeva <s.piyush1024@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>, 
	trondmy <trondmy@kernel.org>, sfrench@samba.org, 
	sprasad@microsoft.com, vaibsharma@microsoft.com
Message-ID: <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
In-Reply-To: <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
References: <m2qzlx7eye.fsf@gmail.com> <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
Subject: Re: NFS delegations behavior analysis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_1622515_91336704.1782212671525"
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: NFS delegations behavior analysis
Thread-Index: Wcet4PThi1S9kRhT1qfuO7oxCHha+Q==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,samba.org:email,desy.de:dkim,desy.de:mid,desy.de:from_mime];
	TAGGED_FROM(0.00)[bounces-22782-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,samba.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[desy.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB86A6B69A4

------=_Part_1622515_91336704.1782212671525
Date: Tue, 23 Jun 2026 13:04:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Piyush Sachdeva <s.piyush1024@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>, 
	trondmy <trondmy@kernel.org>, sfrench@samba.org, 
	sprasad@microsoft.com, vaibsharma@microsoft.com
Message-ID: <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
In-Reply-To: <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
References: <m2qzlx7eye.fsf@gmail.com> <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
Subject: Re: NFS delegations behavior analysis
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: NFS delegations behavior analysis
Thread-Index: Wcet4PThi1S9kRhT1qfuO7oxCHha+Q==



----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Piyush Sachdeva" <s.piyush1024@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Chuck Lever" <cel@kernel.org>,
> "trondmy" <trondmy@kernel.org>, sfrench@samba.org, sprasad@microsoft.com
> Cc: vaibsharma@microsoft.com
> Sent: Tuesday, 23 June, 2026 12:50:16
> Subject: Re: NFS delegations behavior analysis

> On Tue, 2026-06-23 at 15:31 +0530, Piyush Sachdeva wrote:
>> Hi,
>> Lately I have been running micro benchmarks around the `ls` command and
>> reading through the code documentation of the NFS client to better
>> understand the client side caching behavior with and without
>> delegations.
>> 
>> Understanding so far:
>> Delegations (both file and directory) are granted by the server to the
>> client, indefinitely (until revoked or under the watermark) to cache
>> attributes. The caching of data is a result of the attribute
>> cache. Hence forth, a directory delegation will cache the directory
>> attributes and the names of the files in the directory, and a file
>> delegation will cache the attributes of the file and the file data.
>> 
>> Workload run:
>> I focused on the 2 workloads below, doing 2 passes of a large flat
>> directory (with close to 100K files) -
>> a cold pass, and warm pass using the cache from the cold pass:
>> - lslr - ls -lR on both runs
>> - lsmix - ls -R (cold) and then ls -lR (warm)
>> 
>> I also played with the rdirplus behavior using both the default
>> heuristic behavior and the `rdirplus=force` set at mount time.
>> 
>> Numbers:
>> actimeo=5s, rdirplus=force, ACLs off, flat_dir
>> ==================================================================
>> 
>>                  |         LSLR          |         LSMIX
>>                  |  (ls -lR cold / warm) |  (p1 ls -R / p2 ls -lR)
>> Operation        |  flat cold  | flat warm |   flat p1   | flat p2
>> -----------------+-------------+-----------+-------------+---------
>> READDIR calls    |    27       |     0     |   27        |    0
>> READDIR recv B   | 23,603,024  |     0     | 23,603,024  |    0
>>    call type     | readdirplus |    --     | readdirplus |    --
>> LOOKUP           |     1       |     0     |    1        |    0
>> GETATTR          |     3       |  100,000  |    2        | 100,001
>> ACCESS           |     2       |     0     |    2        |    0
>> -----------------+-------------+-----------+-------------+---------
>> Elapsed (age)    |  ~14 s      |  ~62 s    |   ~16 s     |  ~63 s
>> 
>> 
>> Observations:
>> When doing `ls` or `ls -l` on a directory, due to the open(2) on the
>> directory, the client gets a directory delegation - caching the
>> directory attributes and file names. However, as we don't have file
>> delegations due to no open(2) calls to any of the files. Henceforth,
>> the cache of file attributes is governed by `actimeo`.
>> Now here is the interesting bit, if the next `ls -l` is issued after
>> the `actimeo`, a massive GETATTR storm hits the server, doing stat()
>> calls for every file in the directory. As a result, the performance of
>> this warm `ls -l` run ends up being worse than the cold pass. I am
>> guessing this is most likely due to the compounded "rdirplus" being more
>> efficient than stat() calls.
>> 
>> 
>> Proposal:
>> For large directories, this ends up being a massive problem, taking 1-2
>> minutes when enumerating a directory on the warm passes.
>> - An easier way to tackle this could be to do a rdirplus=[auto | forced]
>>   instead of issuing the stat(2) storm to the server: When the client
>>   notices that there are cache misses, which would be the case of file
>>   attributes, instead of fetching file names from the directory-delegation
>>   cache and attributes from GETATTR, the client does a READDIRPLUS to
>>   the server, nonetheless.
>> - A more tedious would be the to cache file attributes as well, as a part
>>   of the directory delegation. This would end up requiring a change in the
>>   NFS protocol spec though.
>> - Bulk GETATTR calls: I am uncertain of the feasibility of this, but
>>   what if, the client could do 1 GETATTR call for getting attributes
>>   for multiple files.
> 
> 
> ls is such a hard workload to get right, because we don't really get an

100% agree. And there were a couple of attempts to address this issue
(second ls that is slow).

> indication in the kernel of what userland's intentions are. It's
> basically a readdir() call followed by a bunch of stat()'s, but at the
> point where we're getting the readdir() call, we don't know if userland
> intends to stat() those files or not. We have to make a guess about
> that intention.
> 
> In this case, it sounds like the directory cache was valid, so the
> client decided it didn't need to do a READDIR at all, but the
> individual files had caches that timed out.
> 
> So imagine you're the kernel client and have been given that second
> readdir() call: Why should you decide to do a READDIRPLUS at that point
> instead of a regular READDIR?

May we need some kind of client-side heuristics, like on the server side
for open-delegations, where after seeing some `stats` for files in the
In the same directory, the client will decide to switch to READDIR (v4)
to get all attributes in one go.

Best regards,
   Tigran.

> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_1622515_91336704.1782212671525
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNjIzMTEwNDMxWjAtBgkqhkiG9w0BCTQxIDAe
MA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCAFpeN5hH535tOT
woHxA65LfYWULe7jE/gzVtCcm+OHjzA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0BAQsFAASCAYAY3CDsz9aBwEUbfeNdE1P8424u
FgArpnAnsiR8JOWD4Am/MO+ZO+U5xPsxycILGnttpd6cP44JQLkzhgZaLTw6bF5djBbOqutqfHd1
b0fQ41sFOAI0qMOcKa3psDit16PQASaB/4a+wD+bq4LGej/rXWwJW4Hx6+GWZ53soCbchS0xEDgW
Z7FJCaxIowLG/4+jOdqjGJQBybfR1TnmU/Gbx7YXzoXG4HHjOdsp345ZwMT0neiEtYZtgFtFpNs1
WNytVSnLto8fQMIEluN2HOEobb52ixbVLEp6vcRN8vthqMh74e3X/kzQVWeiatT2CDqpqiHaXgFa
hJMBG1ECKpPC11iXdEC2K3oWTccj0RVIgor9lNpK8QjdX0Oxbc/ANmahfGrj1D95IfN1gGlZr/Wz
hBw8Z3Od47CiFQTLWRsqqZr/iSBjV2jMD7qv7kELUzmqI4JB+SYwckIvujveKxTEQU1qSuJWoisz
E7U3aiB9ab4JSfFZ4udLOTp41Sr6OI4AAAAAAAA=
------=_Part_1622515_91336704.1782212671525--

