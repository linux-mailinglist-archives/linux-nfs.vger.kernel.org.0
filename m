Return-Path: <linux-nfs+bounces-13930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2134EB39B88
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A587A8C38
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D94A23;
	Thu, 28 Aug 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="bEqsYDN4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C627BF95
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380503; cv=none; b=urKedtLbNrFZhYmvU5kYIG0Bd+PsBG9nb707BkpXSRceDtyvUb+/iLp1l8OyAzHygJVapRekKIgQXfxEp66p1GkWGh5DyxSZVW94vVfVO+3GqNlxLiPSmPetMXATm/XSkzHoSKuansNIzGiQePClrt4YKXmDJBqx2QJOEBpqcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380503; c=relaxed/simple;
	bh=EQB9GIPfpn0ly+NIaXAz5mzJ/QJGf7f8cfNC6FKE2jk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=e7zK79afzxKe88iJ4ERy6FqoVVlJNZ15PX9KnrpMY3Wwy2B83sEgS1QuuI6i7uu1wybIpQD2VX3A/6fh7Bsf2JrQbaBzHCa+hbaCJY3iCSYxn0LR/4Fjd9dmlxC0Lz9OEgGy27TcD/8skE1eB1gbIPnATBY9fUGnBOaXZjld9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=bEqsYDN4; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 84F2D11F7D0
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 13:18:32 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id D7F9111F744
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 13:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de D7F9111F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1756379903; bh=yqOa/r9jxxoFxbZm8j8ilQUjlxkNal7QDZtKIjNAY8k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bEqsYDN4H6aUPoqMuU15LOc4FI4O9mfZ9zDfRt78+z4AaUlLtbvlnR0+lxW3HAQnB
	 2WqeUkQTGT8+k3/l4i4KSp5lxxRjNfK2fzDpUAqkanqfndyapaquz+mX4mEWMwE714
	 whcn0cRHoZ/glmg4stJm8/55ml6cB8IjCb2ZsIlo=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id CF53B120043;
	Thu, 28 Aug 2025 13:18:23 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id C669840047;
	Thu, 28 Aug 2025 13:18:23 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 1CB6B100033;
	Thu, 28 Aug 2025 13:18:23 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id E61E02004C;
	Thu, 28 Aug 2025 13:18:22 +0200 (CEST)
Date: Thu, 28 Aug 2025 13:18:22 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1033126368.4575635.1756379902624.JavaMail.zimbra@desy.de>
In-Reply-To: <aLA4nePqG4rAUXMU@stanley.mountain>
References: <aLA4nePqG4rAUXMU@stanley.mountain>
Subject: Re: [bug report] pNFS/flexfiles: don't attempt pnfs on fatal DS
 errors
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_4575637_1852892323.1756379902850"
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF142 (Linux)/10.1.10_GA_4785)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: XebRs2kFsa2pBzWBb1/e0fSV7d2uIQ==

------=_Part_4575637_1852892323.1756379902850
Date: Thu, 28 Aug 2025 13:18:22 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1033126368.4575635.1756379902624.JavaMail.zimbra@desy.de>
In-Reply-To: <aLA4nePqG4rAUXMU@stanley.mountain>
References: <aLA4nePqG4rAUXMU@stanley.mountain>
Subject: Re: [bug report] pNFS/flexfiles: don't attempt pnfs on fatal DS
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF142 (Linux)/10.1.10_GA_4785)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: XebRs2kFsa2pBzWBb1/e0fSV7d2uIQ==

Hi Dan Carpenter,

Indeed, the behavior looks incorrect. I will look at it deeper and submit a fix.

Best regards,
    Tigran.

----- Original Message -----
> From: "Dan Carpenter" <dan.carpenter@linaro.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, 28 August, 2025 13:08:13
> Subject: [bug report] pNFS/flexfiles: don't attempt pnfs on fatal DS errors

> Hello Tigran Mkrtchyan,
> 
> Commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
> errors") from Jun 27, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
>	fs/nfs/flexfilelayout/flexfilelayout.c:880 ff_layout_pg_init_read()
>	error: uninitialized symbol 'ds_idx'.
> 
> We recently changed ff_layout_choose_ds_for_read() from returning NULL to
> returning error pointers.  There are two bugs.  One error path in
> ff_layout_choose_ds_for_read() accidentally returns success.  And some
> of the callers are still checking for NULL instead of error pointers.
> 
> Btw, I'm always promoting my blog about error pointers and NULL:
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
> It's not really related here, since we should not mix error pointers
> and NULL but I still link to it because that's what they taught me in
> my Trump Wealth Institute course on Search Engine Optimization.
> 
> Here is what ff_layout_choose_ds_for_read() looks like:
> fs/nfs/flexfilelayout/flexfilelayout.c
>   758  static struct nfs4_pnfs_ds *
>   759  ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
>   760                               u32 start_idx, u32 *best_idx,
>   761                               bool check_device)
>   762  {
>   763          struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
>   764          struct nfs4_ff_layout_mirror *mirror;
>   765          struct nfs4_pnfs_ds *ds = ERR_PTR(-EAGAIN);
>   766          u32 idx;
>   767
>   768          /* mirrors are initially sorted by efficiency */
>   769          for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
>   770                  mirror = FF_LAYOUT_COMP(lseg, idx);
>   771                  ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
>   772                  if (IS_ERR(ds))
>   773                          continue;
>   774
>   775                  if (check_device &&
>   776
>   nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
>   777                          continue;
> 
> Bug #1:  If we hit this continue on the last iteration through the loop
> then we return success and *best_idx is not initialized.  It should be:
> 
>		if (check_device &&
>		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node)) {
>			ds = ERR_PTR(-EINVAL);
>			continue;
>		}
> 
>   778
>   779                  *best_idx = idx;
>   780                  break;
>   781          }
>   782
>   783          return ds;
>   784  }
> 
> Bug #2: The whole rest of the call tree expects NULL and not error pointers.
> For example, ff_layout_get_ds_for_read():
> 
> fs/nfs/flexfilelayout/flexfilelayout.c
>   812  static struct nfs4_pnfs_ds *
>   813  ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
>   814                            u32 *best_idx)
>   815  {
>   816          struct pnfs_layout_segment *lseg = pgio->pg_lseg;
>   817          struct nfs4_pnfs_ds *ds;
>   818
>   819          ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
>   820                                                 best_idx);
>   821          if (ds || !pgio->pg_mirror_idx)
>                    ^^
>   822                  return ds;
> 
> This needs to check for error pointers.  But also if pgio->pg_mirror_idx
> is zero, is that a success return?  I don't know...
> 
>   823          return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
>   824  }
> 
> fs/nfs/flexfilelayout/flexfilelayout.c
>    842 static void
>    843 ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
>    844                         struct nfs_page *req)
>    845 {
>    846         struct nfs_pgio_mirror *pgm;
>    847         struct nfs4_ff_layout_mirror *mirror;
>    848         struct nfs4_pnfs_ds *ds;
>    849         u32 ds_idx;
>    850
>    851         if (NFS_SERVER(pgio->pg_inode)->flags &
>    852                         (NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
>    853                 pgio->pg_maxretrans = io_maxretrans;
>    854 retry:
>    855         pnfs_generic_pg_check_layout(pgio, req);
>    856         /* Use full layout for now */
>    857         if (!pgio->pg_lseg) {
>    858                 ff_layout_pg_get_read(pgio, req, false);
>    859                 if (!pgio->pg_lseg)
>    860                         goto out_nolseg;
>    861         }
>    862         if (ff_layout_avoid_read_on_rw(pgio->pg_lseg)) {
>    863                 ff_layout_pg_get_read(pgio, req, true);
>    864                 if (!pgio->pg_lseg)
>    865                         goto out_nolseg;
>    866         }
>    867         /* Reset wb_nio, since getting layout segment was successful */
>    868         req->wb_nio = 0;
>    869
>    870         ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
>    871         if (!ds) {
>                ^^^^^^^^^^
> This doesn't check for error pointers either.
> 
>    872                 if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
>    873                         goto out_mds;
>    874                 pnfs_generic_pg_cleanup(pgio);
>    875                 /* Sleep for 1 second before retrying */
>    876                 ssleep(1);
>    877                 goto retry;
>    878         }
>    879
> --> 880         mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
>                                                       ^^^^^^
> Uninitialized.
> 
> 
> regards,
> dan carpenter

------=_Part_4575637_1852892323.1756379902850
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQGrSZ0tLzGu9JoeeaXGroSzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yNDEyMDQwOTQzMjZaFw0yNjAxMDMwOTQzMjZaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKZ1aJleygPW8bRzYJ3VfXwfY2TxAF0QUuTk/6Bqu8Bi
UQjIgmBQ1hCzz8DVdJ8saw7p5/c1JDmVHqm2DJPwXLROKACiDdSHPf+N8PFZvxHxOqFNPeO/oJhO
jHXG1c/tL8ElfiUlMtEZYtoS60/VUz3A/4FIWP2A5s/UIOSZyCcKz3AUcAanHGEJVS8oWKQj7pNX
yjojvX4aPHzsKP+c+c/5wq08/aziRXLCekhKk+VdS8lhlS/3AL1G0VSWKj5/pOpz4ozmv44GEw9z
FAsPWuTcLXqCX993BOoWAyQDcygAsb0nQQMzx+4wlSGsI31/gKOE5ZOJ3SErWDswgzxWm8Xht/Kl
ymDHPXi8P0ohQjJrQRpJXVwD/tXDwSSbWP9jnVbtqpvLLBkNrSy6elW19nkE1ObpSPcn+be5hs1P
59Y+GPudytAQ3MOoFoNd7kxpVQoM6cdQjRHdyIDbavZrdxr33s7uqSbcI/PE8W5M0iPNnd4ip4kH
UIOdpsjk7b7kEdO4Jf9dDrz/fduAEaW+AUTfb+G42LiftUBXkANa50nOseW3tocadYOTySufN9or
IwvcQ/1uemVd83On7k8bWevfU159x28aidxv8liqJXrrT28tp/QxtGtDXjo9jdkWi/5d/9XfqQgN
IT7KH42fc3ZlaL3pLuJwEQWVtFnWUTRJAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFMmhx6vILo+tVVV6rojJTwL+t2eGMA0GCSqGSIb3DQEB
DAUAA4ICAQARKKJEO1G3lIe+AA+E3pl5mNYs/+XgswX1316JYDRzBnfVweMR6IaOT7yrP+Mwhx3v
yiM8VeSVFtfyLlV6FaHAxNFo5Z19L++g/FWWAg0Wz13aFaEm0+KEp8RkB/Mh3EbSukZxUqmWCgrx
zmx+I5zlX8pLxNgrxcc1WW5l7Y7y2sci++W6wE/L7rgMuznqiBLw/qwnkXAeQrw2PIllAGwRqrwa
37kPa+naT1P0HskuBFHQSmMihB5HQl6+2Rs9M5RMW3/IlUQAqkhZQGBXmiWDivjPFKXJQnCmhQmh
76sOcSOScfzYI5xOD+ZGdBRRufkUxaXJ2G//IgkK2R8mqrFEXxBFaBMc0uMBJHKNv+FO7H6VPOe9
BD9FwfLiqWvGwKJrF11Bk/QSfWh+zCJ8JHPAi6irwQO4Xf+0xhPsxb+jBfKK3I84YMf6zsDkdDzH
lkNPhDh4xhYhEAk+L228pjTEmnbb2QVv52grZ0dbITuN+Hz2ypvLfaS8p06lrht45COlkmuIUVqp
bsc3kRt610qwXSjYcc8zeCQI0Rqnnq+0UN5T0KU7JSzUho6vaTSUG57uc7b3DkIW2Z9VpXX5xKb/
vfl++jC5JzKrbCeS+QOStpXwwaH62IUHwdfWfkvpzb8EFALEmCvu8nlT9NaqYlB/xogMH6oHBm+Y
nxmRQxWROAAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQGrSZ
0tLzGu9JoeeaXGroSzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA4MjgxMTE4MjJaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIIqgCa/BzeWx0XswK3sIa49d70bB
P9I4NhQmd50upU9XMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICADr/xy62uq/VMBntckjk9Pp0edkabQhco7Q4Jr5U
TPVa2zENwXR3nr4XaCzSv7WMQyHjGqJ5eGW37rzNIS8P5NirPtOiDraSypYU8WcK7M71KkOZewIe
u5CP8Ek8fvBZsLDncYo1eSyrjYB7zUOmDlSnHkx+IOlZgja+//dw34NbdfxyEJFhFWRYOnXWWnmf
FYtXs4RUOperaxuA1X0iYn8mKZGvPzJyjMf4i2v4eWkF5OKl4S4MoLNiLQB+AdiKUvdy9PREmoUC
Hx6/sZh6S2S+0zLUe130Qox9hkxVOSooXKOwtgShqYmOGunDFukBFLCM4LCxT/pgAVsLwtyKzuhL
UWnOiz7YsOIsg0+ABUg1u6xJRR0WbUWXctN+BgxPjXfkQiQRqbrOR+p5ybN+loZQEXELC5BFkh0K
PgzmIczKf3vmgZynpPuNWYLzZaPvj1qTomdKaSdw5k7JmESBQWbmR9+nPFxbH95IOcSJiMpP0nOV
cY3xHwTfnrnRf53pP3I3C87ANoyqs7EvGyzRtQ32QS4kUVwU0lYtkzZPhJI/Rd3wDU4UIy2yVLon
ZEDvwx9dhhf+Jzxr2IAkmu3iAuP7CuPXT0ZSYg+WYd9YSZa0k9bebE4Pf4b93cfBVIDqA6u1gszQ
el7Ws5CUKmg8p9v3vn7eQSld0rGqOSqxhIRPAAAAAAAA
------=_Part_4575637_1852892323.1756379902850--

