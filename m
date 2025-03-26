Return-Path: <linux-nfs+bounces-10902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF38A71526
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587FF171BA1
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF631B3950;
	Wed, 26 Mar 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="h3AnBBwQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551215C15F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986681; cv=none; b=m1WGyFcW9BbSmoFrSBi2UX30VEQSqgot4ItCknrPou0wWHrfGFrh3cbjf+Wc6b7GcA8TeV0gey8ojEg9dqtrX2C0r8/mDGwrr6AHAbPP5xhtAGHRl7Ryv3Y5w4X3Jl1Si6RFqCKhBcEQQSfxkIZuPSTsfHOeEWLnCxv1SFZ+vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986681; c=relaxed/simple;
	bh=FMBoZlARdlqxo6ZeRtLboOYUHUG3jcmIC+r8xkbWzhs=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:Cc:To:
	 Message-Id; b=s8pcn1NckyBFsU9nrMCN9qhrj7n4mnk2VxYNcJnenAi/A5/JjDLqfiqC+gdwWngnz5FHbCSH1HuAgscIAl+vzvZGUKe7me1mNUaq3Lpq2IuPtkzHACPKPf2X6u50NHCiKb6hK0/Z+6St59v9yJUfNBzdS5OFcvf7VFrofHB9zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=h3AnBBwQ; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 2E0B511F837
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 11:52:29 +0100 (CET)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 8978213F648
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 11:52:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 8978213F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1742986341; bh=PPr7UfEw/SX0neHxiX8ZIyD3NUd27Rort5gXYy3jxYI=;
	h=From:Subject:Date:References:Cc:To:From;
	b=h3AnBBwQz+2dNq3c5beI1TQACJGab24urdLHkWG0tjWeb/u1CTnUFJVzuwRxlUX+h
	 5/tOYFcr5ENELwMw3SuKPUxZwjwq5KyFoHH8TiewAIH9x14SwU8Os1YQfg95vp6poE
	 gCMKmfMOYZrlcT/tt+BJf46Z2IgrIRb3LGaHn2ys=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 8098520040
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 11:52:21 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 7800440044;
	Wed, 26 Mar 2025 11:52:21 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id D1F1216005A;
	Wed, 26 Mar 2025 11:52:20 +0100 (CET)
Received: from z-prx-4.desy.de (z-prx-4.desy.de [131.169.10.28])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id BB2AF80046;
	Wed, 26 Mar 2025 11:52:20 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by z-prx-4.desy.de (Postfix) with ESMTP id AD87FA0266;
	Wed, 26 Mar 2025 11:52:20 +0100 (CET)
Received: from z-prx-4.desy.de ([IPv6:::1])
 by localhost (z-prx-4.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id oywXdhlV1K5G; Wed, 26 Mar 2025 11:52:20 +0100 (CET)
Received: from smtpclient.apple (unknown [IPv6:2a04:4540:6a22:9a00:359b:e3b5:d1a3:b6d7])
	by z-prx-4.desy.de (Postfix) with ESMTPSA id 20810A00AD;
	Wed, 26 Mar 2025 11:52:19 +0100 (CET)
From: sandro <sandro.grizzo@desy.de>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_91CFD364-C38D-471D-B189-74D49B58B9BF";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: PID/TGID of userland process  in the RPC layer
Date: Wed, 26 Mar 2025 11:52:09 +0100
References: <0D49914A-DB7D-458D-95C3-26D3185E412A@gmx.de>
Cc: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: linux-nfs@vger.kernel.org
Message-Id: <12ACA4E6-1317-4BE7-96EB-0993320E5136@desy.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


--Apple-Mail=_91CFD364-C38D-471D-B189-74D49B58B9BF
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_70EDB225-2BE7-4CA7-B128-56B7CE987F9F"


--Apple-Mail=_70EDB225-2BE7-4CA7-B128-56B7CE987F9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello everyone,

I was wondering if I can obtain the PID/TGID of some userland process =
that originally caused a RPC request to be transmitted from within the =
RPC request itself.

Here is what I did to find out:

With a BPF program I collect the following metrics from a tracepoint =
inside =E2=80=9Cxprt_request_transmit()=E2=80=9D function defined in =
/net/sunrpc/xprt.c:

1. current task name=20
2. current PID/TGID as a return value of bpf_get_current_pid_tgid()
3. The TGID assigned in the tk_owner field of struct rpc_task.=20

=46rom the sources I know that the TGID from 3. is assigned  in =
=E2=80=9Crpc_init_task() function=E2=80=9D defined in =
/net/sunrpc/sched.c:

	task->tk_owner =3D current->tgid;

In the output of the BPF program I see records with the following =
entries for the above metrics:

1. "kworker/u389:3=E2=80=9D
2. "PID": 455045, "TGID": 455045
3.  =E2=80=9CTGID of tk_owner": 3989219

Here, I presume, the thread (kworker) that executed the =
"xprt_request_transmit()=E2=80=9D routine differs from the one that =
assigned its TGID to the tk_owner field in =E2=80=9Crpc_init_task()=E2=80=9D=
.=20

But there are also records like this:

1. "kworker/u128:4"
2. "PID": 1457360, "TGID": 1457360
3.  "TGID of tk_owner": 1457360

Here, the kworker did both the jobs.

Now to my questions:

1. What determines which thread (kernel or userland thread) executes =
rpc_init_task()?=20
2. How can I, with certainty, obtain the PID/TGID of the userland =
process  from inside rpc_init_task() ?

Thank you for your answers.

Best regards,
Sandro

_______________________________________________


--Apple-Mail=_70EDB225-2BE7-4CA7-B128-56B7CE987F9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><div><div>Hello everyone,</div><div><div =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div><br></div><div>I was wondering if I =
can obtain the PID/TGID of some userland process that originally caused =
a RPC request to be <font><span style=3D"caret-color: rgb(0, 0, =
0);">transmitted from within the RPC request =
itself</span></font>.</div><div><br></div><div>Here is what I did to =
find out:</div><div><br></div><div>With a BPF program I collect the =
following metrics from a tracepoint inside =E2=80=9Cxprt_request_transmit(=
)=E2=80=9D function defined in =
/net/sunrpc/xprt.c:</div><div><br></div><div>1. current task =
name&nbsp;</div><div>2. current PID/TGID as a return value of =
bpf_get_current_pid_tgid()</div><div>3. The TGID assigned in the =
tk_owner field of struct rpc_task.&nbsp;</div><div><br></div><div>=46rom =
the sources I know that the TGID from 3. is assigned &nbsp;in =
=E2=80=9Crpc_init_task() function=E2=80=9D defined in =
/net/sunrpc/sched.c:</div><div><br></div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>task-&gt;tk_owner =3D =
current-&gt;tgid;</div><div><br></div><div>In the output of the BPF =
program I see records with the following entries for the above =
metrics:</div><div><br></div><div>1.&nbsp;"kworker/u389:3=E2=80=9D</div><d=
iv>2.&nbsp;"PID": 455045, "TGID": 455045</div><div>3. &nbsp;=E2=80=9CTGID =
of tk_owner": 3989219</div><div><br></div><div>Here, I presume, the =
thread (kworker) that executed the "<font><span style=3D"caret-color: =
rgb(0, 0, 0);">xprt_request_transmit()=E2=80=9D routine differs from the =
one that assigned its TGID to the&nbsp;</span></font><font>tk_owner =
field in =
=E2=80=9Crpc_init_task()=E2=80=9D.&nbsp;</font></div><div><br></div><div><=
font>But there are also records like =
this:</font></div><div><font><br></font></div><div><font>1. =
"</font>kworker/u128:4"</div><div>2.&nbsp;"PID": 1457360,&nbsp;"TGID": =
1457360</div><div>3.&nbsp;<span style=3D"caret-color: rgb(0, 0, =
0);">&nbsp;</span><span style=3D"caret-color: rgb(0, 0, =
0);">"</span><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">TGID of tk_owner</span><span style=3D"caret-color: rgb(0, 0, =
0);">":&nbsp;</span><span style=3D"caret-color: rgb(0, 0, =
0);">1457360</span></div><div><span style=3D"caret-color: rgb(0, 0, =
0);"><br></span></div><div><span style=3D"caret-color: rgb(0, 0, =
0);">Here, the kworker did both the =
jobs.</span></div><div><br></div><div><span style=3D"caret-color: rgb(0, =
0, 0);">Now to my questions:</span></div><div><span style=3D"caret-color: =
rgb(0, 0, 0);"><br></span></div><div><span style=3D"caret-color: rgb(0, =
0, 0);">1.&nbsp;</span>What determines which thread (kernel or userland =
thread) executes rpc_init_task()?&nbsp;</div><div>2. How can I, with =
certainty, obtain the&nbsp;<span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">PID/TGID of the</span>&nbsp;userland process =
&nbsp;from inside rpc_init_task() ?</div><div><br></div><div>Thank you =
for your answers.</div><div><br></div><div>Best =
regards,</div><div>Sandro</div><div><br></div></div>______________________=
_________________________<br></div></div><br></body></html>=

--Apple-Mail=_70EDB225-2BE7-4CA7-B128-56B7CE987F9F--

--Apple-Mail=_91CFD364-C38D-471D-B189-74D49B58B9BF
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDjQw
ggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1MDEyMzU5NTlaMEYxCzAJBgNVBAYT
Ak5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBD
QSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAs0riIl4nW+kEWxQENTIgFK600jFA
xs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8/3AQPYBo7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpw
XgfCvnKxmq97/kQkOFX706F9O7/h0yehHhDjUdyMyT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSq
adM3p+d0vvH/YrRMtOhkvGpLuzL8m+LTAQWvQJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZ
zVKTNORvPrGPRLnJ0EEVCHR82LL6oz915WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusCh
SsZEn7juIsGIiDyaIhhLsd3amm8BS3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8
v7bPZiJRaT7ZC2f50P4lTlnbLvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZ
zR4MbpjTWdEdSLKvz8+0wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zF
p2pyYUOiuzP+as/AZnz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbds
Gac+diahjEwzyB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQY
MBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ5DAO
BgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VS
VHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYB
BQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNy
dDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOC
AgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110Q+BABABglkrPkES/VyMZsfuds8fcDGvG
E3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0tDUoL01ugDdqwlyXuYizeXyH2ICAQfXMtS+r
az7mf741CZvO50OxMUMxqljeRfVPDJQJNHOYi2pxuxgjKDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tf
fjRKn8I1D1BmrDdWR/IdbBOj6870abYvqys1qYlPotv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8B
GdpEqyFVa+I0rpJPhaZkeWW7cImDQFerHW9bKzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4
NJjaMxpk+g2puNSm4b9uVjBbPO9V6sFSG+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi
8SKNohAOKnUc7RIP6ss1hqIFyv0xXZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT
9uSI2Xvhz8p+4pCYkiZqpahZlHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbU
vDM9slzZXdI7NjJokVBq3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4Rz
adUwggdGMIIFLqADAgECAhEAmUYNxPr0ho/hZY1bWIM2XTANBgkqhkiG9w0BAQwFADBGMQswCQYD
VQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29u
YWwgQ0EgNDAeFw0yNDA5MTMwMDAwMDBaFw0yNjA5MTMyMzU5NTlaMIG/MQswCQYDVQQGEwJERTEQ
MA4GA1UECBMHSGFtYnVyZzEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEOMAwGA1UEYRMFR09WREUxJDAiBgkqhkiG9w0BCQEWFXNhbmRyby5ncml6em9AZGVz
eS5kZTEPMA0GA1UEBBMGR3JpenpvMQ8wDQYDVQQqEwZTYW5kcm8xFjAUBgNVBAMTDVNhbmRybyBH
cml6em8wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCyjdFCoVsUI2wAddAjjv8O0tiG
r7BVK98Mx92NH6LS85SXxp9mcMESIYA/JKGT4QHOQiWlw/Vh/ByUEtZVYgrzUcq56m58Grfb9HaE
cTSAxWVzqKzZO1fWgLNU687w4Rwv/iQZYXJy9rBXo9dGPvzk3zNsfVmp2QUnnHFw1MemTJ5g3j0i
HsXvEFBUmuJxB6lp0mDaJiCj2CYmn6B7qPDm/4EJhNRxxHNXauMmT6K7Rigja6/R9FX0AmytC33W
qfx0Icm6zO1lfAiXoP+nb9jFxnE8CgyjCzdSdcEAKKWioZO/xwPACGcg6ks+L/GDWEsW0MOyJ/ze
s7ZapbwYf0mE1mpV65R58kq1vxjDbHz+IRNwmXMZg2hgF4xlJqHpLXoa43JrFC6qqwTnQmhz8lze
NPdHEKGxHEB3hZnTP5jkLbEgn78VjpKC5QWT024enJLNGpogtL87xAe6WXaY1JLwkCTNJgBPo57/
3ZgXFE0t/AGzD76EFEMcEfo9Jr4Fr0TugH75CCYto1Ze7rl+chUSZ75pp3xSR/2x5Hqc95jOmKE0
PMXrbEE1pcMHJubfejHVaTmaoUIooUtb1i9ER3K82Q14iCx5wY4uziozhsZbDgg0NyPF41YxbXD1
zY2YAdWKx8WqzwFn20kPM4I63yTvimk3Jej5fqLzrPyMKjIjYQIDAQABo4IBszCCAa8wHwYDVR0j
BBgwFoAUaQChxyFY+ODFGyCwCt2nUb8T2eQwHQYDVR0OBBYEFLEqua9xc958iCdtQ8ambOk7Q3OE
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEF
BQcDAjBQBgNVHSAESTBHMDoGDCsGAQQBsjEBAgEKBDAqMCgGCCsGAQUFBwIBFhxodHRwczovL3Nl
Y3RpZ28uY29tL1NNSU1FQ1BTMAkGB2eBDAEFAwIwQgYDVR0fBDswOTA3oDWgM4YxaHR0cDovL0dF
QU5ULmNybC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0LmNybDB4BggrBgEFBQcBAQRsMGow
PQYIKwYBBQUHMAKGMWh0dHA6Ly9HRUFOVC5jcnQuc2VjdGlnby5jb20vR0VBTlRQZXJzb25hbENB
NC5jcnQwKQYIKwYBBQUHMAGGHWh0dHA6Ly9HRUFOVC5vY3NwLnNlY3RpZ28uY29tMCAGA1UdEQQZ
MBeBFXNhbmRyby5ncml6em9AZGVzeS5kZTANBgkqhkiG9w0BAQwFAAOCAgEAp7gd8CFxvBmNzvDT
mXIqzfAWtIhhpyRvKWhRV9GNMQbU3ie33xZIjthOPO6lV94GS4pp/fSWMBA63loldqvPGRNI7R7P
TvG2tngRC4cIxuXiPvBF/CerhPu7yOMnaz1MrKE4A0QGnm6v9Hy+NbC0eOYSv3TW39SDFi9VPnbU
g52CnJfND+fvhAdrPM3ccl4qaThn3idsc65bfGQ++ZXWgU7xw15b2vdCd1csaNRZp3KprTIBWx6Q
kBfb4OjS8NuEF90bRMGBNzaQ/MGqDlSDLjcSCfTyfhZ9qKYa9T/zmYrV5+a4x0j72iAiqtP/91Zt
NvCFD9SPr0FtAIWg7omrxr15QAG1UetuYP8WQimkxMbd8Yk/zjvHyj5d9/ySeXAHeZZ0YpgvsLs/
ynAseI7LEZwUvkQqaVpLbrEM+iIQwDppM1tPN1/utz8oRDv4Ez6t7DVmHTwNT2gN1dMoRu5pxBwm
LkpUUtYNlb+U/w7u/+H5IbbWp+h8jR9d2zEZ7Uk5DSy6G8LUFOg1T1NO94r85c2hzpDciaRI/a9a
SdhOcW3RQP7JBrmcp7oKWL83fDHBdRWXqskeGshFdwpWrTNSdfBgEGBRRV78CwPCw43jpdu6S/Gi
Taj0nDPf/RS8COT3qePkpUYHzOns5HS3FiHRGkdpGsXGblmo8ejeQmsQDCkxggPNMIIDyQIBATBb
MEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFO
VCBQZXJzb25hbCBDQSA0AhEAmUYNxPr0ho/hZY1bWIM2XTANBglghkgBZQMEAgEFAKCCAUMwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwMzI2MTA1MjA5WjAvBgkq
hkiG9w0BCQQxIgQgpXqMZhDut8sP3N4VnUzhcooQuyncxCBhQtodvk8WtNcwagYJKwYBBAGCNxAE
MV0wWzBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMT
R0VBTlQgUGVyc29uYWwgQ0EgNAIRAJlGDcT69IaP4WWNW1iDNl0wbAYLKoZIhvcNAQkQAgsxXaBb
MEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFO
VCBQZXJzb25hbCBDQSA0AhEAmUYNxPr0ho/hZY1bWIM2XTANBgkqhkiG9w0BAQsFAASCAgBJY4ZH
J/wyJYKN7V9Eqf6T5DVGa5nrVwg3f5KKKBqKixn0a2YfS0V2UJwrl5ZomMpu1q5znWJzki/zMatz
PTV4DuX85vhF0NqoRubjD3QgyFDDHaUD+24uqBoR8Ajc9df5S3C6lNGmYImUeXPWPhq1P3qqd8/h
FYGmD+hgrymyf3swMOn4WOyX/gvAwA3fVTqAsV+JEIADtNWt2u9WJNnlisGT0RtRaBRt2to7KuoB
xZ0OspPZGvTy+Vn+6omZVHBUULTkdn3HfgzMpHE4W+iKfxRh70xc1HTG+aBKUDUZBKQF3W3NrKl/
umqmIdjShWrjVfDd3osNtq3M+ekdJmPB5iZVraQ55b3XZzvXQrNWfcZfOitm+KY9y2Z7shy2PTOb
MiqLIp7hrPVgE2/zWkqbWnKlAHbjUWZyhKpG5QpfJYMQyJj6JcVUH0fYWcuJbTOyk+LbuOofOqD+
mpmSzNki8NS1cK6XKxmD70ikKSNA62WCnOaLihRaheEVdIaETF4VLMojMiekXSKY1j5G4Wci20H5
+9G0w+LepuQ4QLQQIcOoFjTauMTModQM0vUAP6knOcqJGU+LaReeAvnJuCUP271AH/GZPdc41XBe
bDcyna7tw6BEm03wbNE0mmaxqJLyZOfjP3bZYKGeVXHwaTnWptmPqrA7+f4la8XceO262wAAAAAA
AA==
--Apple-Mail=_91CFD364-C38D-471D-B189-74D49B58B9BF--

