Return-Path: <linux-nfs+bounces-22864-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7xW2GgWLPmrpHgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22864-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 16:21:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A86CDDCA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 16:21:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=desy.de header.s=default header.b=wr1JEbvI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22864-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22864-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=desy.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59B3C302737C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2837C10C;
	Fri, 26 Jun 2026 14:21:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4432A3FE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 14:21:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483715; cv=none; b=D5J6Tdjbt1E233OIxaszSnlRCEYp7YGTi3uN+gnkA1dca0ihsaF9YOWtobIn7R6PzzpfjTKipGKwl9ubpVF1k74Xv5T8mCgbhcDsjoFnF9E9Gz93gISe0IQ5NV8rb7nmWHer9gBrNv3/V+aApEif1daTr0bwsnNdb0+9g8PvIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483715; c=relaxed/simple;
	bh=VWToxeExjqJqgl0tx9C/JuQVsYRTHaaKSXwapiKoTrY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qKlNU/m3rRS1Adl7FCIgJhZtiGhE7JvMWF+rVa8ZysSWp2E4VUBsyLZm0paqzhLl6/FEriq4NytSMGXAymiD/+2ru+E00FsxA2gPYMvEQb++dk+KJVw+IFu04SUaJFwBxNkYtmjHQm3xRWg+MAsK4r+JJIFYpAn4cQ/okN61lG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=wr1JEbvI; arc=none smtp.client-ip=131.169.56.155
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id EB75313F647
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 16:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de EB75313F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1782483710; bh=I4RrAwIyBMQiBckDwrTkgdxgAznsDPFyNDqX+XLqEbs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=wr1JEbvII4+A+ulM/7qx5RjxdaiK4iSZgO+2WBwRp+B7C03woHoBx1UWp4BMORAcc
	 RUTkSDTXwwpABhepAyKvkKSu8v7fn0vZySoU9AT6eWDgs15QRZeJM4EJqhbsCy1DMu
	 K7BI5Qj03nOWVPcF1GEJm6NMtFF+EZABKXQ9J7mM=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id DD2B4120043;
	Fri, 26 Jun 2026 16:21:49 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id D2D6A40045;
	Fri, 26 Jun 2026 16:21:49 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id E3AAD160059;
	Fri, 26 Jun 2026 16:21:47 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 93BDE80046;
	Fri, 26 Jun 2026 16:21:47 +0200 (CEST)
Date: Fri, 26 Jun 2026 16:21:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy <trondmy@kernel.org>, chuck lever <chuck.lever@oracle.com>, 
	anna <anna@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1951524341.2815907.1782483707418.JavaMail.zimbra@desy.de>
In-Reply-To: <7290d0262d782c0c3b26b8167975face1ae91053.camel@kernel.org>
References: <20260626125216.1467845-1-tigran.mkrtchyan@desy.de> <20260626125216.1467845-2-tigran.mkrtchyan@desy.de> <7290d0262d782c0c3b26b8167975face1ae91053.camel@kernel.org>
Subject: Re: [PATCH 1/1] [RFC] sunrpc: inject process namespace into
 machinename field
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_2815908_1428247137.1782483707531"
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: sunrpc: inject process namespace into machinename field
Thread-Index: phg2YS3ECMiih29cq5yxV1QR1eSPVQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22864-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email,desy.de:dkim,desy.de:email,desy.de:mid,desy.de:from_mime];
	FORGED_SENDER(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[desy.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E84A86CDDCA

------=_Part_2815908_1428247137.1782483707531
Date: Fri, 26 Jun 2026 16:21:47 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy <trondmy@kernel.org>, chuck lever <chuck.lever@oracle.com>, 
	anna <anna@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1951524341.2815907.1782483707418.JavaMail.zimbra@desy.de>
In-Reply-To: <7290d0262d782c0c3b26b8167975face1ae91053.camel@kernel.org>
References: <20260626125216.1467845-1-tigran.mkrtchyan@desy.de> <20260626125216.1467845-2-tigran.mkrtchyan@desy.de> <7290d0262d782c0c3b26b8167975face1ae91053.camel@kernel.org>
Subject: Re: [PATCH 1/1] [RFC] sunrpc: inject process namespace into
 machinename field
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: sunrpc: inject process namespace into machinename field
Thread-Index: phg2YS3ECMiih29cq5yxV1QR1eSPVQ==



Thanks, Jeff. Yes, Chuck has sent me the link too. Indeed, we have
noticed that while tracing some applications with perf.

Chuck as well suggested using the COMPOUND tag, which sounds more
reasonable and will work with RPCSEC_GSS. I will post it after testing.

Best regards,
   Tigran.

----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "trondmy" <trondmy@kernel.org>, "chuck lever"
> <chuck.lever@oracle.com>, "anna" <anna@kernel.org>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 26 June, 2026 16:04:36
> Subject: Re: [PATCH 1/1] [RFC] sunrpc: inject process namespace into machinename field

> On Fri, 2026-06-26 at 14:52 +0200, Tigran Mkrtchyan wrote:
>> On large shared machines often multiple jobs of a same user run in
>> parallel. For debugging, it's usually impossible to identify requests
>> coming from different processes.
>> 
>> The batch systems like HTCondor or SLURM start every job in it's own
>> namespace, thus passing namespace info to the server will help by
>> debugging.
>> 
>> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>> ---
>>  net/sunrpc/auth_unix.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/sunrpc/auth_unix.c b/net/sunrpc/auth_unix.c
>> index 6c742a3400c4..b218cfa9871a 100644
>> --- a/net/sunrpc/auth_unix.c
>> +++ b/net/sunrpc/auth_unix.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/sunrpc/clnt.h>
>>  #include <linux/sunrpc/auth.h>
>>  #include <linux/user_namespace.h>
>> +#include <linux/pid_namespace.h>
>>  
>>  
>>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> @@ -117,6 +118,28 @@ unx_marshal(struct rpc_task *task, struct xdr_stream *xdr)
>>  	struct group_info *gi = cred->cr_cred->group_info;
>>  	struct user_namespace *userns = clnt->cl_cred ?
>>  		clnt->cl_cred->user_ns : &init_user_ns;
>> +	char ns_aware_nodename[UNX_MAXNODENAME + 1];
>> +	int ns_aware_nodename_len;
>> +
>> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>> +
>> +	/* the process runs in a dedicated namespace */
>> +	if (pid_ns != &init_pid_ns) {
> 
> FYI, Sashiko has some comments on this that seem valid:
> 
> https://sashiko.dev/#/patchset/20260626125216.1467845-2-tigran.mkrtchyan@desy.de?part=1
> 
> Fetching the user namespace ID might not be correct in some async ops.
> 
> 
>> +		/* Format as: <pid_ns_inum>@<current-hostname> */
>> +		int prefix_len = snprintf(ns_aware_nodename, sizeof(ns_aware_nodename),
>> +			"%u@", pid_ns->ns.inum);
>> +
>> +		if (prefix_len < sizeof(ns_aware_nodename))
>> +			strscpy(ns_aware_nodename + prefix_len, clnt->cl_nodename,
>> +				sizeof(ns_aware_nodename) - prefix_len);
>> +		else
>> +			strscpy(ns_aware_nodename, clnt->cl_nodename, sizeof(ns_aware_nodename));
>> +
>> +		ns_aware_nodename_len = strlen(ns_aware_nodename);
>> +	} else {
>> +		ns_aware_nodename_len = clnt->cl_nodelen;
>> +		strscpy(ns_aware_nodename, clnt->cl_nodename, sizeof(ns_aware_nodename));
>> +	}
>>  
>>  	/* Credential */
>>  
>> @@ -126,8 +149,8 @@ unx_marshal(struct rpc_task *task, struct xdr_stream *xdr)
>>  	*p++ = rpc_auth_unix;
>>  	cred_len = p++;
>>  	*p++ = xdr_zero;	/* stamp */
>> -	if (xdr_stream_encode_opaque(xdr, clnt->cl_nodename,
>> -				     clnt->cl_nodelen) < 0)
>> +	if (xdr_stream_encode_opaque(xdr, ns_aware_nodename,
>> +				     ns_aware_nodename_len) < 0)
>>  		goto marshal_failed;
>>  	p = xdr_reserve_space(xdr, 3 * sizeof(*p));
>>  	if (!p)
> 
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_2815908_1428247137.1782483707531
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
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNjI2MTQyMTQ3WjAtBgkqhkiG9w0BCTQxIDAe
MA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCBCAC6VViUo5BDQ
5NaeiDEabgjB7WqKzPQW3xsY/mXE+zA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0BAQsFAASCAYBOOyGhoMBPNPucTJ3rqJm+U+o/
HxdqJ2EScsU0Jqf2RkOHgPAG2/P2ZX6pm4uhXyttl2KT1b35a7uwJrfx3sfJK+Eo47HKv84VY0o6
41cI2dwBKc6ToIa8/trE6y3asEpxVpLzjnDxFw1ffb4kJdTwMtwzujR2VmjmaySwfmY88wXIK6yA
SrysAwax17jGjNnnCpmNOpeaPFyumKRRa5/8Dw7UQOU1lVwD/s/2wFzsRuDlLZR0dDbnH2v6iAnn
QOyYTtMkpFvzOan394fiESOky7iLQ0kag0+FGPQLMAw8KPelTlEVO9/8ZhDYGr2LmQMBbJg7BlFp
/k3uKbhce4KRD0vn6wMI1KUn8A9xa/w8oyWKBKQ0pniVzE8St7Q/z9Waswx1rFVeuOxxBFT6ZHtU
IQs2C5Yv6hJpfTXTPuy7zN7ggup1SSEYUoMSN70Ro2bKowIQqh9WkwnI/7Q75lTq7kixQdmwMe6e
TMwdsZTr6bcwyBsJw+WPSaV8JxKwRQ0AAAAAAAA=
------=_Part_2815908_1428247137.1782483707531--

