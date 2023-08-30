Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20678D1DF
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbjH3B7u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 21:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjH3B70 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 21:59:26 -0400
X-Greylist: delayed 2072 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 18:59:17 PDT
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0137.outbound.protection.office365.us [23.103.208.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDF19A
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 18:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=awXftr1u+yOPRKtfvS1cGLFEk/BZobTdClfQvKpJ+pFXiKed3UtRGxXwToaO3CfWXcI8h8sc6PfprFPxSEWH4xnE8WEB/X04DRCWPNLRoCcq7mZ6F0IA/eWa9KfKO6yIpTOqdxudWfuJpGwGS/iXmNqR6RUZIQ+EqIUCVq4kf6ieoFRzVrTEvUB2rnVKHdF74NHx4tQSf7Tgx5/tOx5kupgCvI9+s9H4zAlJpzk1RfdMUuG4rRHCgv0ed8OrVtnLugNHHhVoskAJ4BOV7Mlf57+l1YEoeuoG6mg5jJLpOh/ReWTDl7gGtA4NLxGv8qeSoaFhoFHpOp8t5PEbJRTg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV07QRhHg5BIdZ931xYsE58oi6xoEkwx2mZNlhKx3kk=;
 b=RNtd6TaXMU8BwyCkN6AqiYHkRe+1rcd7fIhfPhrYBO2SIjnGVqH/EwlRyeEYAGG6ThLAkpkw/Q6K2gQ5a42ahpaXhU+9H+esyaRBYcDp9+9GKBoK4mB5UvfKUJU/TzWrhANZBLQwaKPWs59Otn3v3avT12jihVdKtznU8NWQYFVgXvQqIPckhqnDM5W+xPq6YDejr0TipwNeH/3LFdHWHdIz5/XxpEG39/uD62ylHxToBPIXqBe4FGamhgzgPZeltJpkePtPHrS/rP+X8b9/Q8kfe3xQ3DR44ru/CDcWz/COzxAhXemwYdJGnERc8uVoUAtkSH+hz9cbi/05/6ah3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cert.org; dmarc=pass action=none header.from=cert.org;
 dkim=pass header.d=cert.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cert.org; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV07QRhHg5BIdZ931xYsE58oi6xoEkwx2mZNlhKx3kk=;
 b=aWB62bCE5UJ0DXv0g/uBBu8vKmpGmdsDHk5yqDd9+dNlvJ52nPC94yJmNRGjTWmvbhVSfsYTiWP7KmrLpfkpyFN82tTcT9wqMCuL6G5vqmVlK+BCkml0CMfoflz5IuOsRjuhV30gDx569wgNcWzfGvm5yCt2p5tGibXTq24R9nQ=
Received: from SA1P110MB0975.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:172::5)
 by SA1P110MB1710.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:196::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 01:24:43 +0000
Received: from SA1P110MB0975.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c638:72fe:1040:1751]) by SA1P110MB0975.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c638:72fe:1040:1751%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 01:24:43 +0000
From:   Chris Inacio <inacio@cert.org>
To:     Rick Macklem <rick.macklem@gmail.com>
CC:     Tom Haynes <loghyr@gmail.com>, NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfsv4] pNFS/Flexfiles testing at Oct. Bakeathon
Thread-Topic: [nfsv4] pNFS/Flexfiles testing at Oct. Bakeathon
Thread-Index: AQHZ2hnX+QNnblbvPEaoV8Z0FeQrBrAAheAAgAF4PACAAA8kgA==
Date:   Wed, 30 Aug 2023 01:24:43 +0000
Message-ID: <B42FE0D6-F3C1-48D1-BE1E-3B09BF0A7FD2@cert.org>
References: <CAM5tNy7Q63k+9+f9zrctZrm-NzCbYn8OjYSirQ8g+g7yLaK9jQ@mail.gmail.com>
 <CAMa=BDoUS8ny1X+GjDR1hDGg1h9zjtSzet1Rtu8=GwJfsu-kJQ@mail.gmail.com>
 <CAM5tNy6ecGrKToFneMi14MnWP5BhS39kJJpxLCmk4AWgeU6+tg@mail.gmail.com>
In-Reply-To: <CAM5tNy6ecGrKToFneMi14MnWP5BhS39kJJpxLCmk4AWgeU6+tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cert.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB0975:EE_|SA1P110MB1710:EE_
x-ms-office365-filtering-correlation-id: 59c135e5-c733-4b46-1295-08dba8f7e39c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: weUpWfwHd6w+Qk3tJ1wBuwYwOMOjRXxpUms4ySy6Vk8EvxTrkdjSWDRE+DDk/FDt4rGbdDhjzGToCDohjzGbq2z0/shborGGzcwqLP7Yria/U5+xGU/RYCD8odmWhwn0UuREoU3YgFjPJpOKWrGAmdeJW9dGJX+hkYOs41wX3+9WnsyPNt3W7qkT7ZUqUj/oocMzg0fHElStH2Jf3vb7jabH7RhRcvS0ACx6+E/ElYQxbNToDYH3vM/qE9w7EfthBQIAtnasv71337aWBEF02l8mEegAu32inuwIThzzAzlVE+lrzjN0DdW6fFDhA3q2uyoHn01E6Or0xYX5em0VLW24hMmcDpr2pQx76jk8SXZztceIrlzuiQtwDzIktM5ytqJBP4DEci9x5rkcY9uL/IbmAH41sXW7KVQDlV6Ye5yGyacoKxt0hJzd+c3J7sx/Vj3N86mRkQefRrZxzdurI83cfXEPQ0GJ7mVhEmdoq4IGLXAwOSzeG1fr6gqz1KAKLIu3tuph+D251yt5fSWnK28vlt8HHcpwX2kHOd+7kKyXNHtbhvIwLtagmFDBfnnoAvh18ks6myDVqwIXwACbBV5pq3SnFEM/tUsURjSl4x2s+PccyPmzwScL34eWqnQN/fteEd8+3ueGfUFFnopvaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB0975.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39830400003)(396003)(451199024)(1800799009)(186009)(6512007)(38100700002)(38070700005)(41300700001)(6916009)(66899024)(82960400001)(4326008)(33656002)(2906002)(86362001)(4744005)(2616005)(26005)(41320700001)(8676002)(5660300002)(36756003)(8936002)(99936003)(71200400001)(66946007)(6506007)(66556008)(6486002)(66446008)(64756008)(66476007)(54906003)(76116006)(122000001)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azh0a2VIYWhnWHI0d1g2aUh3OHB3VlJuWUUwMEpiM0Z2NkFyWHF5VFFwbHR0?=
 =?utf-8?B?QSt0YUNhcUM2VW9VaUlMcGFTZVpNUjBtUFZNNDBldmhvZlpzSzFYTFllRE90?=
 =?utf-8?B?ZXBINHNZaE9KTjNZbWNZaG5zaXZYakR3YTJoNUZkNjdZbGRucUtJN3dUZmVK?=
 =?utf-8?B?VzBoV2VKRXNsc3pPRmgvdURrNDBBZlJ2Ung5YjFnb2NrelR0b2FLQnRoSW5K?=
 =?utf-8?B?VkwxMkFkU0FVakxsbVlVSTg3YXBIdU5CNFBLbmd5cVgvZnZhWGZnUmVzQSt2?=
 =?utf-8?B?VGw2N20rRlAvS05TQWVYRWpISDgxT3k2NGN0TUorT3hCMWFiMEpjZU9JeDZ3?=
 =?utf-8?B?L0FsQ3JjbnUrZU5ZcmU2YTdjYVpTcFZIa2NtRldnb2RhYUg0SGZMcmtCNEpX?=
 =?utf-8?B?djZiZUFrMjY5dXNkTWY1YkJNa1dyMnVSQS9IOHRFMzNtQVhnR1VBZ0VqMkdN?=
 =?utf-8?B?RGpoU09NM3RuZlo5ZGg0OGhFdFd3NS81ODJOdzA0K0NGMGE2dGFNb3UzUXp5?=
 =?utf-8?B?UGdXVm9LVzVjWU1hUjcwaDRCRWdRdHRVWVNSWWRtTEVobm1zWitHT2x6ZCtu?=
 =?utf-8?B?RURPcWh0cExBZVJWcS8reWNpWlVHdCt5dFBRQm1DaS9xWW5IQTRDRi8rZ2w2?=
 =?utf-8?B?MTNXK1h5akZmVjFVT0lmeFdYRTBMaXJuaTUvK0Q2THNpTnpSZURZaFQzVmFz?=
 =?utf-8?B?aTM0TFVPWTB1eXhxNXJkTzY0alFVSXdmNHNGNDN4RzVSVTNkVUpodm9DWmVQ?=
 =?utf-8?B?K2RYS3hBOEhleXBxVThhQ005MWJlcDhiY2VINHNPNkg3NHFTMUxITGw2V0RK?=
 =?utf-8?B?RWdXMGpvay9SRC9lR0toS29KYytGbm9ENVk5M0N0cXhSRlovMGdlcDRjVTFP?=
 =?utf-8?B?MUlJeUN4SG15TytEUGUyT05kMzZ4bDFmRGtLRlhteFZ1SDhxcnJwL0Z1SVVG?=
 =?utf-8?B?bGVFdS9OR0tRaEllSkUyaDViRy9aUEtHRXI2dnJlK1lPMjh4TExxandmbUxE?=
 =?utf-8?B?aFUydk5IZEtNQ1UxTEkvajBBbExDTC9SYy9HLzQrcWFoR1VLazlnRkozaUR3?=
 =?utf-8?B?bHlENUpmTUlPaGRVU3gxcGdTc0RXL3FHMnRKMFJpblFVUUZML3pwWElodTBk?=
 =?utf-8?B?cHpqTE01UFBxUk1TK0hYSHBJb25BbFhSU2JJaWpDUCs4SUp3RXQrQ1dDblZk?=
 =?utf-8?B?RFNRT2lsamVYWE9tNGJOUVhuczZwbE1LTVdKQitRS2Uvb0hLSGJHMWllUmMr?=
 =?utf-8?B?WngzVVVHZTR1VTFicStmQ2JiSUUwZFoyUlBibjc0SWdNY1lJb3o2akw3bnJp?=
 =?utf-8?B?em9MbHFJdFZYM1U5Zll0TEJUSjNYTFRpUm1PUTN6MTM5MDQ0dEZ5ZU9Bdi95?=
 =?utf-8?B?RjNqMXpEdnJINlYwaEh6VG9rOVZNTGhkMkxLN3cxUTF1YXJmWlNCbWo3ZUpC?=
 =?utf-8?B?NEFrRHViMVdYWkZCcjgwTXNCWkF4YmU3cjJqc0tGMm5KY0RqUGQ5dlUxdVMr?=
 =?utf-8?B?NXYxeUZrZEQ5elZsUWZlVlBhdFl0b05NS2RGd2dlSGpkR3A1SGlta214eUxu?=
 =?utf-8?B?V3R1WkZUeG9jQVMwcFpFbGpUTk1LblppemVaWC90LzkzaStvd3ZSWkUreE8z?=
 =?utf-8?B?bjBNWElrRGxWMTI2dkRONzIycFZwTTM5REZ4b2RHUnN5T3ZLZlNHWkYrVVRo?=
 =?utf-8?B?MVB0SFdxZWdyMUJacDArUkxyUnpXbzRqblF3ays4WlFvZ2tWN2hkMW4rRStj?=
 =?utf-8?B?dmErZnI5SjMvaFpHSWJVMHpEU3JDeU1LK3pSRGdCYjlGcHdHWHZJR3JUNWJQ?=
 =?utf-8?B?dkVmQy9qNVFlQVBtdnFZd0NYR1dLR1VCZ0pKTldOR0lEUHpZdkZGMnZaSTFH?=
 =?utf-8?B?ZFY5QmR4eS9VVkphcHJPdXc2R0N1ZWRkWkJOSnp4QWpTRERGSDJ1YTRvZTlv?=
 =?utf-8?B?MUlpTWtSNzRhSE5hNmxNYnpWNUFJN0srWEJ4SG4vZFVaK2RVbzhiT2o1ZlNP?=
 =?utf-8?B?NG5vYU5keitua20wVlhrTEZXM3JWNHdlVmJlTlJaUEhOdEZvbFEvS05LLzJz?=
 =?utf-8?Q?Dip7mS?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A3133FAD-C6C6-4EA5-AFA8-D7C1928A4D80";
        protocol="application/pkcs7-signature";
        micalg=sha-256
MIME-Version: 1.0
X-OriginatorOrg: cert.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB0975.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c135e5-c733-4b46-1295-08dba8f7e39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 01:24:43.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95a9dce2-04f2-4043-995d-1ec3861911c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Apple-Mail=_A3133FAD-C6C6-4EA5-AFA8-D7C1928A4D80
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

>=20
>>=20
>> My clients will also have the implementations, normally they only =
talk to my server, but I can bring a standalone client for testing.
> The FreeBSD pNFS server never issues delegations, so delstid wouldn't
> really apply.
> (The non-pNFS server does do delegations. Is delstid generic enough
> that a non-pNFS
> server should do it?)
>=20

[ci] For the noobs in the audience, if you don=E2=80=99 t mind, why =
doesn=E2=80=99t FreeBSD ever offer delegations?  (I=E2=80=99m getting =
just smart enough to be a bit dangerous.  Give me a few more months and =
I=E2=80=99ll really be able to ruin something=E2=80=A6)


> The only other one I recall is the LayoutReturn with an error after =
the MDS
> reboot. Not something we'd want to test at the Bakeathon, I'd guess?
>=20
> Thanks for the info, rick
>=20
>>=20
>> Tom


--Apple-Mail=_A3133FAD-C6C6-4EA5-AFA8-D7C1928A4D80
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCC/cw
ggXsMIIE1KADAgECAhEA6/fTJgzoAOMFLzfsLtmFbDANBgkqhkiG9w0BAQsFADCBiTELMAkGA1UE
BhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoTCUludGVybmV0
MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFuZGFyZCBBc3N1
cmFuY2UgQ2xpZW50IENBMB4XDTIxMDkwMTAwMDAwMFoXDTI0MDgzMTIzNTk1OVowgecxDjAMBgNV
BBETBTE1MjEzMSMwIQYDVQQLExpDRVJUIFByb2dyYW0gLSBQZXJzb25hbCBJRDEjMCEGA1UEChMa
Q2FybmVnaWUgTWVsbG9uIFVuaXZlcnNpdHkxGzAZBgNVBAkTEjUwMDAgRm9yYmVzIEF2ZW51ZTEV
MBMGA1UECBMMUGVubnN5bHZhbmlhMRMwEQYDVQQHEwpQaXR0c2J1cmdoMQswCQYDVQQGEwJVUzEV
MBMGA1UEAxMMQ2hyaXMgSW5hY2lvMR4wHAYJKoZIhvcNAQkBFg9pbmFjaW9AY2VydC5vcmcwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDW9LNPYn51JKJWbilOZQqiBDLTJXY3JUyp43WF
iQK120DEXL/zMzZHzGyGL3cT5PmfeTPrGGpCYHGtU00IrbvsU5IR7CRS8ZaActYak50Nm5bI4vke
24cK2uRKwBsfHeXCHL5NPWhRRjxciySdJ4gSceEaXGlsWx2QBwIEdO69DgrjT93zQNxgBWXfuBCq
9OQG10/cZ7f6ajKMfV3uogQEWTj0CJ0qhdVmEELyfahiDAv7aDCVthn7+CDizL5li6Vjc4UYa+8u
dxygXuawAiOVlH1Cy7Vpv1DmRvs5GNT9+4FT5ZHZxlgCXohXnPGOC8UWc/e6dgOzRSAVMeir68CJ
AgMBAAGjggHtMIIB6TAfBgNVHSMEGDAWgBR97nHQH+upYW2PZoStDysH4jHbvDAdBgNVHQ4EFgQU
U41WAoKgog04KQ2JpFEfQ6UdSMowDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0l
BBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMGoGA1UdIARjMGEwXwYNKwYBBAGuIwEEAwMAATBOMEwG
CCsGAQUFBwIBFkBodHRwczovL3d3dy5pbmNvbW1vbi5vcmcvY2VydC9yZXBvc2l0b3J5L2Nwc19z
dGFuZGFyZF9jbGllbnQucGRmMFUGA1UdHwROMEwwSqBIoEaGRGh0dHA6Ly9jcmwuaW5jb21tb24t
cnNhLm9yZy9JbkNvbW1vblJTQVN0YW5kYXJkQXNzdXJhbmNlQ2xpZW50Q0EuY3JsMIGKBggrBgEF
BQcBAQR+MHwwUAYIKwYBBQUHMAKGRGh0dHA6Ly9jcnQuaW5jb21tb24tcnNhLm9yZy9JbkNvbW1v
blJTQVN0YW5kYXJkQXNzdXJhbmNlQ2xpZW50Q0EuY3J0MCgGCCsGAQUFBzABhhxodHRwOi8vb2Nz
cC5pbmNvbW1vbi1yc2Eub3JnMBoGA1UdEQQTMBGBD2luYWNpb0BjZXJ0Lm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAWv994AbsdDjjJHbJryl+WeZN5lHoOFy0IM5AzQJhxJSmvjacL9sfXj5o0OR9PzVB
oRz6UWJobCL69Hs3xZ8op91IZDShKfb1GxibOvRKqBw9tgXE8Xci+yFVwAbXA/bTAuC+vaO4GbgG
30JikU53th5SnK+lfzqJGuxUGxi5T1ovcea3A7F1aw2hSmDs7rNDc8WvmACpbGpaAOCR2lD43+0g
VPIO8E7LZrYKr3FCC5UYICTvYogWJyZb6TMvf4bvT2GTYR5OteqQGKOVelKtl0RfJxG9eB8+B4hE
WVXx5sNHOMnP1cL9/yHGzE1nmwJwtRz5zWwhgrkDS9W5kwvvuTCCBgMwggProAMCAQICED+9NPK6
UvwO0wpXo4HhvmQwDQYJKoZIhvcNAQENBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE0
MDkxOTAwMDAwMFoXDTI0MDkxODIzNTk1OVowgYkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJNSTES
MBAGA1UEBxMJQW5uIEFyYm9yMRIwEAYDVQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCEluQ29tbW9u
MTIwMAYDVQQDEylJbkNvbW1vbiBSU0EgU3RhbmRhcmQgQXNzdXJhbmNlIENsaWVudCBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAID+ylt3d8Yf7IL751mKVa3A6p6xB+gmKzYJovEv
TDpZQJyrnPJAKUAlknIpeI+bBmoQfLdkB/8Y/FDbqBggxucRGcYBaEc/2ZLs3TSSuGSfG/XSJtlz
1Eym4CMJbj6d/PqC1eT+pKVGeQBl5T1u6LZOfovh6/RmqnXR24du4RWqHYvyTJyGXvoT5Qxp7IXW
YPiobYhzA5WnwnvS8ZKO+3pjqZGoZrq1/bMt0n/8y4Obi4k0vVddCnWXZoCVvJfRuhoYwWy4fetG
jHVo/bCa+L6z7Vk/MrdxBkBVd3KlLzdJAYArq4ve7NlNir1eX64PMwWVvzQl0WKsNfGWg4vD26cC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBR9
7nHQH+upYW2PZoStDysH4jHbvDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJ
MEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0
aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0
cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQ0FAAOCAgEAdtOnxJK15L21ll2tmbfV
StSZ/45E30VSTkN7in1pPNM8jKYh6X3RhWS2sgW45/05mYSrgmvFe9yUrVTwZqPphjLPcRmxqULB
Fi1tJj5Kyo5SYwX1C31yfIMirJ10eQnwg0JYijIMWN4xPRxsl1TTcgloyu6NbEALVDAFb281ZD7x
y2l8Antz5VSa7j2v6bt77LSCUEJK4C7Ym6eiSulXAg3zk2N/k4h2F5E4ry3LC3f0FPOTbWHy3YQt
SPAYDJ9EfGTJZoneaKpo6UAWKkTLMZyIqmpP2NKcq280GIjGKt/e1KYQaleX4U6RpAkOTWGxxiB3
0NSRXnIDmLchCVFDZCBVUfPJH98J+UwwX9yzIw3nOCmjV6Wb+FSCmBVnQG7gwLXj6GuA7hsnzMtq
LP3Ww8Z7dyyqF3EuUqj6Q7utW5utfcotyZphypT+5P+phFCgEMW1rhjhRLjKAxks56sWGVcw5Vhu
9diWT+IGM+oi1FQQskyNmBujqF8cUMOAS8ZjKaOzAozIh91yS9TuhOVacSaJSt64uDWlQe7h+GCm
jXze/fW8heXJo0tpv/BKdmajibmDiWld2bGfotmCIPmR69mzLseVcPafkuxIkLusGRMuCjJFzWCq
jWbsIxbkl1HFPrN03dS4N4hh2Y7XW6CWLXlOeQR9Zln0p5DeCuOSHnMxggOgMIIDnAIBATCBnzCB
iTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoT
CUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFu
ZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhEA6/fTJgzoAOMFLzfsLtmFbDANBglghkgBZQMEAgEF
AKCCAdEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwODMwMDEy
NDMxWjAvBgkqhkiG9w0BCQQxIgQgl6aXJL/sr+acRFVF6K3j1ntwO17rtYBqQ9oo38mg660wgbAG
CSsGAQQBgjcQBDGBojCBnzCBiTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlB
bm4gQXJib3IxEjAQBgNVBAoTCUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMT
KUluQ29tbW9uIFJTQSBTdGFuZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhEA6/fTJgzoAOMFLzfs
LtmFbDCBsgYLKoZIhvcNAQkQAgsxgaKggZ8wgYkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJNSTES
MBAGA1UEBxMJQW5uIEFyYm9yMRIwEAYDVQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCEluQ29tbW9u
MTIwMAYDVQQDEylJbkNvbW1vbiBSU0EgU3RhbmRhcmQgQXNzdXJhbmNlIENsaWVudCBDQQIRAOv3
0yYM6ADjBS837C7ZhWwwDQYJKoZIhvcNAQELBQAEggEAUf54mgL53xisa7HS36D+mk8kGFR9cLQH
6TiAkJ/SWV1ENjG6BIUuAu3pO3YPNNe+Nr9Wt4HEppk05Zz0LGR9xoIP2YfhdGYB1Bb9ZEpLJ4lh
X/wHwEeQoC2RTgqww0ICk/RDBiHjBxvoVBobUeU/qDST/Op43rI8HzNVoPuywTpH6SrghQSHNf7y
JbHD4uwh4tzV/q128+2tknQJINow3hkyUa/eEKsVe6ZvvciDKBWlSNOevXVJQmVYP2jlrF9DzUwn
x6U1NUqLCGmE/tNpwgrTbTELUf1l57YzaxTJ+bZtgm0HyCdO53AJF6zNfUwTW7XP6AVMKHDefX+y
hV0BRgAAAAAAAA==

--Apple-Mail=_A3133FAD-C6C6-4EA5-AFA8-D7C1928A4D80--
