Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55563E21EB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 04:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhHFCy6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Aug 2021 22:54:58 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:35304 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhHFCy5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Aug 2021 22:54:57 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 22:54:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1628218483; x=1659754483;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vpzINDgur0X50s1pwkPOGNA4SMavugQXgtyOrlWovwk=;
  b=ijyN/hpa2CnKKXfJOl+c+CWkINYC45+kMZHHZOyFkn6MdxiOYillGPB+
   2RQT1IQ+Dz4IcNJm+jF2nRw4QhYQ3YbVsfj1d0MfNXQy/qnXAo320E2NH
   Ym6qKcxG3YTuoDWVv+amJuCxGWM/PIxTiUcshBYUURcKUXGATnvvabZ7a
   HdFQzUMNs9vEEcHvUzc6NI4jIO/nPp2QFDW6A7j79UPK4tGX4MF1NP2Ar
   8yOeLRIsWAYOk5JWaP+RGRstUb4O3lPbcLiDqXk2B30nfOeVHBXBvkpPn
   Q/pxn+rzFW989+SishW6V2E6kYgPWCIeNr+TgUtc3MKaxkj0wp/PvMAl0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="36276446"
X-IronPort-AV: E=Sophos;i="5.84,299,1620658800"; 
   d="scan'208";a="36276446"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 11:47:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njdfnbVyhEVy1+yWQSUBx50ZiO+rejS557v1d8hDdpJuSdNJClKGYYPwtOPg7hQu2qUCIsHRfGWjbHMP9/DaQbu1WnjZGfndS+NJ3yrOmETSWiLindj21s/9g3A4YwWNbKMUaUrqR6IVIfrJ/fgmRtjBfHSXB5Gmfo4M/zQxtRReEMOyVY5MlWoko21xJNhWXewGnihIdpwNkaoUTOk6JjJEDHGw73GxJFJTIwd7ofubiq9izM75Kp9aBbEqk5BudflHmHE+bpzVjAiLOLHewIzB71wNs1y+U5bH7GOTP0aPWL1EzroSCtHbv6Tlc0iSO5kntIfnHAvkd5bC01MNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpzINDgur0X50s1pwkPOGNA4SMavugQXgtyOrlWovwk=;
 b=TJLJdHb9E2TqANSppmZgWYrxc25A4doMPwYgVsx5umdjuWcAjm9uSSflTvQc4zcQ5EEpMQQH9JqokMRPrHIWwrxAMvy9QAahHhLXCoOd7uLaQBTe3lYfn0vvB303klZqArDax6Eq1hX9fxGy1SEyegrphPlvyMjN4Q0E260Q/hq673tECl0eCxqsWdagMDZgeQX6yRl6UgJ+bZLihJqqAv5SpJY5uZnlBiqieBxoTJlm2glSejTfJFsenBApQpyc6/mUlAIhdNHZQ80y0klyxuSkWMAWqFwfVqpYSVd5gXf2Q1PXUslhIFxIQnD/SqrHB5Bf9ev8hAaP/8s7bK9ljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpzINDgur0X50s1pwkPOGNA4SMavugQXgtyOrlWovwk=;
 b=XwMTk4Q5KCmnFYswsAIePd0uL91ejA55g7BPICzxYTqLC3wHsLBUiGQ4v7AWzjld+7MizKVVhUH27C8Omb4fmgPTtpR6L0dIPWfIOOcC3jqQwO3e29FaHp1SO5CDccE3jFU/ZsBLxIxSwLqwf7e1qWVFtd+0gfElOQL8Rm+stM4=
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com (2603:1096:404:e::16)
 by TYCPR01MB7124.jpnprd01.prod.outlook.com (2603:1096:400:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 02:47:29 +0000
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368]) by TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368%5]) with mapi id 15.20.4394.019; Fri, 6 Aug 2021
 02:47:29 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] nfstest: python3: fix rexec error while calling
 self.process.stdin.write
Thread-Topic: [PATCH 1/2] nfstest: python3: fix rexec error while calling
 self.process.stdin.write
Thread-Index: AQHXim09YQ3wybV6MEeT4I6vtT/MSA==
Date:   Fri, 6 Aug 2021 02:47:28 +0000
Message-ID: <TY2PR01MB21247B7616B9A21424F7CB1089F39@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c18d94b-00a8-4631-bd66-08d95884880e
x-ms-traffictypediagnostic: TYCPR01MB7124:
x-microsoft-antispam-prvs: <TYCPR01MB71244118E5711D692FF0915489F39@TYCPR01MB7124.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yz3IqBwAstiYkAtXxlMCnEGs/4h57Y/WqCpTy/PJsPW8Ztwc1AQ2Zw7QGvHv/H4Y7UddlL/R8XR0Ji6ssi6B/C2olZupTk/LW/Lt3cPI40bVJ+vh/cW+N2JJWS4lCrm4Bc+iR3MzOEQhSeQJaqXjxhCl41JwxwKDW8t7WtB3+9dnR5RFBDHjYt2H5keDbs1uC1HJUimZyb7SEX4a/lzVtnK46cX4bkrwkAY/E9D1+SGNfYBrkm5NWXNQ/zeUhOzb6IH0/9f71Tlxb8qH8LIghldhZUQvVsWVz9PjLUpzfAypb8ovcgerjCle2VtHOzfNqywGADXMQUU7ZWcEbjexPNTizKIKaZxxBcaEKSlLruAE+6kxwgEEqpmAt67kmKwUvQlO6pFRW1jA+46wA/R3L/NlwpZpV0fNjugsdfrXsAtsw+u5IZSmFw/my5IOYo6+xt/L0Ziy3+iIbxC/C2Yi+1wX59Hugff91LKQlMDBR2ZlT14f7pu/3QN7Wpul9l2o3+3+YZ0NguWvsew6MOjBjEmcQ2G7kRnZbb/vpDocnj6C6ZjD9lwlg1E6NSE2v+BnfkSen4/eWBjf4pTKOduYR1N9irqhCraYN5Q9hyVO7xjUBakO4Pj3/WRCXhllEaS8YjNC+3wE/swFqWjv1H3tvb7W4DQ7feCJD1Lqbp6l07ooXG9L126A3UPXk7q+4r9CXGqmaz44dsGzlav59jtHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(86362001)(55016002)(9686003)(122000001)(7696005)(6506007)(26005)(38100700002)(33656002)(186003)(66446008)(5660300002)(38070700005)(8936002)(52536014)(316002)(508600001)(71200400001)(91956017)(83380400001)(64756008)(85182001)(8676002)(66556008)(66476007)(66946007)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cXFoTWppMXNDa1Ewdkp6QWdudEIwRzVObVdzNWpuZy9iNzg3Y05ZSHVzRTA1?=
 =?gb2312?B?UzlyQ3hSU054eFlOVFZCVldObCtzVXhKc0JhRXN4SUFKQ0wvOW16Wlg3Zm5n?=
 =?gb2312?B?S1dDazVBVXpRN3dtY2xkYm5pbDJoeDIrdU5Bd3pWYTIyeEVmeHJVdXJ1MVR4?=
 =?gb2312?B?aERxSWNKQ0wvVW1MWUZyWFltZ0VWRmYrS0ptZEp6TTg0WTlCMXk1RmdicUhm?=
 =?gb2312?B?YVZzc2xxaTAxZW5WREZ2WkhobTluTDgvNzdvaVRRa0M3NWpXZk1TdC9lTDQy?=
 =?gb2312?B?d1RJSDFXMmNSd0JuWm1DNlVOdFNOazQ0cWYzTGgyS1B3NXB1ZEFiQm9jL1NT?=
 =?gb2312?B?SjFreGFoQjBYUW5JNnVaalhocmhRZHVFVVovVllzaG9GYXdRR2p2aFVYV09w?=
 =?gb2312?B?d1JCWDRldCtadGYxVHo3UEhYc0RCdjBhMm11L25ZZ1NNYVpJa0dDWm1nSTZ6?=
 =?gb2312?B?cC9MUy9CbkhSeDZrOExCaUhoYnlBUVB4bmN1RFg2Z3RjUjFBMHZGTDhxSTgr?=
 =?gb2312?B?RnRHNG1UVHRsb21DNjRvQ0NBdmFPRzJIRWZCWTJRWENqd3pyUnlON2Z3U1R5?=
 =?gb2312?B?TkJrcktFQ05yVTdJVzhPeU5kdWVlcWpXTTBXTVB1VnFWZERKOVlscDVIWC84?=
 =?gb2312?B?ZExkSElzNnpQRGV5KzE4UStrZTFuNVUzSEF1Y3E5T014RkdBMlZoZ2ZZUyth?=
 =?gb2312?B?azBKTE1XYkRpUkhUQmdHM0lVeUMvQXRLMkNqMW5aWDlKVytweS9qbVU3Ti8w?=
 =?gb2312?B?dE5RRVkxTzVQTFRmRjAyMktYbUdPSHQrTXY2ZzVvZE9JVGtGajFVL3Yzc2RL?=
 =?gb2312?B?aDYwMllLZUlISHAzc0hiTk5xRnlTMVNibXNtZnEvQ1V5ZEd1SFBVcnE5SXQz?=
 =?gb2312?B?aDFwd3YvYkVvdTRjcXdIZXRYOEZUTWNpOUVEbjd5c25SR0tJQ2NvazAwT1U5?=
 =?gb2312?B?SUMyZXp5d1Nvc0Z3UTBQdi9yUkQxSkhvRSsxaTg2VTJRVXVDUGxFOEFleldH?=
 =?gb2312?B?UUE2a2EzbGxxMkE1ZnByRk1UR0Z3OWcwUnZzb0Y3cXU4UWRsV2tzd3FDWEsr?=
 =?gb2312?B?ZlUvdFJBSkdPcUFhMDh2Y1BWUXdoRm1iTnhwNXFra2Fsd1cwQ2hBQ0YvWjU5?=
 =?gb2312?B?N2M1VUgyVVdtSituRWlMN0MwRkJSSXBkejM2ZEtadlViMHhYUDcrYTVCQUJh?=
 =?gb2312?B?cFVwRFpMV1U3cWpHZUhsREJLaVpVbnNxbTFqQ3RRUWNPTjVvb2RIdUVLbHgv?=
 =?gb2312?B?Qm5lb0ZJbm51NGZJZ0I0RGhTNGtFOUlvR0FIRGp6QzcwcmQyanNzZ05EOTUy?=
 =?gb2312?B?ZkpzRjdmV2tjbm13SHlVUUc4UXhRK1NwcmxiMmxJODY1dVZ4aVljOWQ5Q2c3?=
 =?gb2312?B?cmZMUHhTYzBxamN3RGh5ZlFtVFdtcUFZYWN2SXpQeGYrVDd2cEowalFMbG9j?=
 =?gb2312?B?N1dUMGxhd2dIbkVnd2Y4Z3ZrUDdZR1lFRlJqL1BQcm5VNmN4TW55L2lTdndZ?=
 =?gb2312?B?djNxVVI5clVOZVp0dU5ITGFxSTVRamRxbGlkUmo3bFRPdmRXeXZKZ2hVOWpx?=
 =?gb2312?B?SmxDbk1hN3RBRDNQdVBmVnNzeXY1WkxUUEcyUkJaTGs2cWRvc2FkazRaOXFp?=
 =?gb2312?B?bVd3T2F5OXoxc3dOemtOelJYNE90NDZMVXFLQ3dkT0JLbVFSWU9SVndnWkNH?=
 =?gb2312?B?V3hoK29aMUdhQTN1OElWb2FiS3R2U1JNaUp0V1QrVlg2K3p3SGNDR3hyNmwr?=
 =?gb2312?Q?W+PeVoUZaoegZmKWTQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18d94b-00a8-4631-bd66-08d95884880e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 02:47:29.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGSC/AoTZZj4JW0afl/Wg3PHtnUIMJ+c2W8mBiJBx+l0lXedwU3VilkfK+lAlhkcfFQECdL2y6eBayAPJ67hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

V2hpbGUgcnVubmluZyBuZnN0ZXN0X2RlbGVnYXRpb24gb2YgbmZzdGVzdCBpbiB2My4wOgoKICAk
IC4vbmZzdGVzdF9kZWxlZ2F0aW9uIC0tbmZzdmVyc2lvbj00LjIgLWUgL25mc3Jvb3QgXAogICAg
ICAtLXNlcnZlciAxOTIuMTY4LjIyMC4xODQgLS1jbGllbnQgMTkyLjE2OC4yMjAuMTA3CiAgVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogICAgRmlsZSAiLi9uZnN0ZXN0X2RlbGVn
YXRpb24iLCBsaW5lIDE2NjYsIGluIDxtb2R1bGU+CiAgICAgIHggPSBEZWxlZ1Rlc3QodXNhZ2U9
VVNBR0UsIHRlc3RuYW1lcz1URVNUTkFNRVMsIHRlc3Rncm91cHM9VEVTVEdST1VQUywgc2lkPVND
UklQVF9JRCkKICAgIEZpbGUgIi4vbmZzdGVzdF9kZWxlZ2F0aW9uIiwgbGluZSAzNjMsIGluIF9f
aW5pdF9fCiAgICAgIHNlbGYuY3JlYXRlX3JleGVjKGNsaWVudF9uYW1lKQogICAgRmlsZSAiL3Jv
b3QvbmZzdGVzdC9uZnN0ZXN0L3Rlc3RfdXRpbC5weSIsIGxpbmUgMTM3MCwgaW4gY3JlYXRlX3Jl
eGVjCiAgICAgIHNlbGYucmV4ZWNvYmogPSBSZXhlYyhzZXJ2ZXJuYW1lLCAqKmt3ZHMpCiAgICBG
aWxlICIvcm9vdC9uZnN0ZXN0L25mc3Rlc3QvcmV4ZWMucHkiLCBsaW5lIDI5NSwgaW4gX19pbml0
X18KICAgICAgc2VsZi5wcm9jZXNzLnN0ZGluLndyaXRlKHNlcnZlcl9jb2RlKQogIFR5cGVFcnJv
cjogYSBieXRlcy1saWtlIG9iamVjdCBpcyByZXF1aXJlZCwgbm90ICdzdHInCgpJbiBweXRob24z
LCBzZWxmLnByb2Nlc3Muc3RkaW4ud3JpdGUoKSBvbmx5IGFjY2VwdHMgYSBieXRlcy1saWtlCm9i
amVjdCBub3QgJ3N0cicuCkZpeCBpdCBieSBjYWxsaW5nIHNlcnZlcl9jb2RlLmVuY29kZSgpIGFu
ZCBzZWxmLnByb2Nlc3Muc3RkaW4uZmx1c2goKS4KClNpZ25lZC1vZmYtYnk6IFN1IFl1ZSA8c3V5
LmZuc3RAZnVqaXRzdS5jb20+Ci0tLQogbmZzdGVzdC9yZXhlYy5weSB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmZz
dGVzdC9yZXhlYy5weSBiL25mc3Rlc3QvcmV4ZWMucHkKaW5kZXggZmE5NDFiNi4uNTE1ODZjNSAx
MDA2NDQKLS0tIGEvbmZzdGVzdC9yZXhlYy5weQorKysgYi9uZnN0ZXN0L3JleGVjLnB5CkBAIC0y
OTIsNyArMjkyLDggQEAgY2xhc3MgUmV4ZWMoQmFzZU9iaik6CiAgICAgICAgICAgICAgICAgc2Vs
Zi5wcm9jZXNzID0gUG9wZW4oIiAiLmpvaW4oY21kbGlzdCksIHNoZWxsPVRydWUsIHN0ZGluPVBJ
UEUpCiAKICAgICAgICAgICAgICMgU2VuZCB0aGUgc2VydmVyIGNvZGUgdG8gYmUgZXhlY3V0ZWQg
dmlhIHN0YW5kYXJkIGlucHV0Ci0gICAgICAgICAgICBzZWxmLnByb2Nlc3Muc3RkaW4ud3JpdGUo
c2VydmVyX2NvZGUpCisgICAgICAgICAgICBzZWxmLnByb2Nlc3Muc3RkaW4ud3JpdGUoc2VydmVy
X2NvZGUuZW5jb2RlKCkpCisgICAgICAgICAgICBzZWxmLnByb2Nlc3Muc3RkaW4uZmx1c2goKQog
CiAgICAgICAgICMgQ29ubmVjdCB0byByZW1vdGUgc2VydmVyCiAgICAgICAgIGV0aW1lID0gdGlt
ZS50aW1lKCkgKyA1LjAKLS0gCjIuMzAuMSAoQXBwbGUgR2l0LTEzMCk=
