Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC17B24EC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjI1SKJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjI1SKI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 14:10:08 -0400
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2124.outbound.protection.outlook.com [40.107.91.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB11B4
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 11:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S342CSZ+XRltnPchE70HbeviO9fXiQs6GdcNInBOg3FQhzvd0KoxRM3h3n7nIcJmZf0IDpSiOKm5NcgNeGtZlhzSms/qWiNH3JM0hB4hCF3q15pPI0fvfPwyeJPWS+j0Ri857QEWvEsOzwJZrwaDtqF733HKxv+9t0oApwptePDp0abOuXSDeWKpPgrCMToyuN5Gx4Ypo9ozH7JWrALAVAHFtmxMGJWaY4t6k5bI+95dNLNS+EP/1XgmxIDxYi7Hm3Bj78LrQkzlGOocfrOejKdZLfitm2oAMMYr8yh/JQyDdTSz2Jh99XceYQweRngDHRItvvsGF75RweqU5J5XBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ+kVUKoiOhIq2joSM279ZZ7yZ3cTUlZrpyhEtJj6b0=;
 b=AefshTTpvSaBxIGS9zFApixExG1MC392P21wwZiT/2qU33+pGNHA93PB23enqHr5cPsMli1HsIVE9jK5uF0CGCDKZ9MCWfNdXvm+rM83JHGbH2urwtpRzmJN5C8nbZxe/svTbBJHm3k0kKxdh/Aq6tStueYP7zeuj/4SxF54+XIhtlcYceaJ/1IlFgs4EZf/9ABTE0ygp+YO+GhOm1WW/Wn2yQJa1axx0lpeRBmlYc1f9q6NO3yrLDR++VlcJoEi2JeB/Gal3EpYdNbTPiTmTnkyxtF2AYe0YdQMeUXKRwkFRFaW6IDvR1Cjt1Us/Ypya/WgstHVv1Sc5aUSb1S4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ+kVUKoiOhIq2joSM279ZZ7yZ3cTUlZrpyhEtJj6b0=;
 b=M8wAwhIFou7N8vqxeYx6Ga5TP1TuYLG5Bt5EnIKBh55+kv4uEbF6wAiCkWC02hOQACtj97rcCcuf5b6nPNwnbU7u9Yz0QXMRhcm5IRCtn2N3wyoNVXlKvj7MlJPzj+4aXowCJuSKFpr+lVSD8Ymz8wfFDuVzOfdw0YyLVdOOYlc54Vb3BFsH+iMIyZCl9fuADy5dN7fk06jUJpGa3TuT2ZzMykAWTS/kl6s2pj7HYXXcbyXGCYMkEd+s1Y4mzGvX+WS0nmdQWj8L6ID9DbQcC1TkmeCoXRBS9bfOBRJF4lNBHcp4ZdEtL9WaogMH2xsa81pZIeX3oluNNhGB0/KJGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by DS0PR09MB11157.namprd09.prod.outlook.com (2603:10b6:8:173::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 18:10:01 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::e37a:a797:7414:1279]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::e37a:a797:7414:1279%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 18:10:01 +0000
Message-ID: <d5876a24-72e1-0839-a07f-23c4033d0abf@nwra.com>
Date:   Thu, 28 Sep 2023 12:09:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Random operation not permitted / NFS4ERR_ENOENT messages
Content-Language: en-US
From:   Orion Poplawski <orion@nwra.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <84b65a4f-272c-69af-245a-423762491315@nwra.com>
Organization: NWRA
In-Reply-To: <84b65a4f-272c-69af-245a-423762491315@nwra.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000306000007010802040400"
X-ClientProxiedBy: CY5P221CA0130.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::16) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|DS0PR09MB11157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2e2b57-646d-4807-9c00-08dbc04e21ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2eLP1gRe62I9C+fD+h0l3X1Em0Y5PhxUpDPNYYppzP5/1UmYhnCDGGrNFsm7mTE07T9MI7U9RHxgQrvuLpOEgYZ8wYcltR/cCO32+Occ1oQf55qEANs+iRHxDV0JinwQp9NdCRtHOpVyeFalsa43QI7gaml8bZLD+unDj9eMm/gkRnxDSSPZ3yJD6u1OwXfv07X3z06kD8muY61fvKUc5bqd7/fACIu1mudU5XHERjYAT3QJIIRbSpHqwdpLmQdb1Z/xgIut6k3t0rOar7r3W7FqsW7hdOnJco+mXS8EM85b0rY65qgWVVwBgUl7rToxhds6BAzSTrKt1xpdpL65wAXLFFCJJzQkI6A/7EQNvpfItzjo7OgWsUGRRGMM84ypscVfHek9/AZd69GgU6aGUq0D0IALfiVPlTR6ZFK6aM7Ka3e5L9klF3rFSD/WWecs7bb56c8vuwNBwvOI2+NRyjlRIe+tpI67nS843S2jaRzkUGcpxX92Wvz7b85ZmMtgFP9ah9PtjEnfTAcfjvi45E/8yxgidIjYzKu+TSOgdauHmyg7l7Av3TZ/mhuzDz41LPzERDdM1yDeP/cQtrQkc6x7rgatuU3K2wERrUToAXoEZKBA4JtXDOsFQPku+hh42dH22C0W9SS+MXo/JH6Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39830400003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(6512007)(6666004)(33964004)(6486002)(508600001)(6506007)(36916002)(53546011)(966005)(83380400001)(235185007)(41320700001)(6916009)(2616005)(41300700001)(66946007)(8936002)(66476007)(8676002)(66556008)(5660300002)(36756003)(40140700001)(38100700002)(2906002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9XL3U3ajVFYTA1clUzdGFaSTdGVmxaamJGQVFRWmxuZGkwSU85YlhrL1FG?=
 =?utf-8?B?SXo5UkZSRy9qcUtqRzRwY0xtTFVSV1BNRlZkalFRdWZBM2VMTFlQVFNYa0J6?=
 =?utf-8?B?OE1ZSjJJdHZCb21FdTVSSmdtTitET3I3elJ2cGpuOGN1RTVxTXkwcno0Wi9z?=
 =?utf-8?B?MWk1RDVIejlPMTIxeTR3RmUxSWc3Mk9NUENCKzlRSmkxVUtyMFV5cTUrcEY3?=
 =?utf-8?B?ODRCSENYNE15SUVvTU5WYXMzcjRleGs2UWxFaDZXa3ZZb280VUVacmZDN1Nw?=
 =?utf-8?B?L05nMVNLY2VGTi9iR1V0Yi95aWJ6cWVUZy81RVJLOXNVRWQxQ1ZDOEJPbkJJ?=
 =?utf-8?B?dHBtU2NkUk9UaDI1TkFpRkhkdnoxdFhhSWgvd09ndXRlWkwzSVRUNUNlOHNw?=
 =?utf-8?B?OFMwR0VTVTBKa3dGVGRkYW5wREs5RSs4bi9iSm54L2d6MnpTTWQydzM0dWtR?=
 =?utf-8?B?UGlQSkxTbGE5eXRoZUJrSDVLbWc4Q01iV0lteGhqY0JzMTB5UWUzM3FBaVZo?=
 =?utf-8?B?L2I4SGp3NFcydS9RbFIwclNGSGVpYSs0MXNiekpqWUVJUlZ5N1V5SVpONkll?=
 =?utf-8?B?LytHenhCUlBUWSszanl0a01HdVdsQ1ByVkZ0S0FoVkh4WC9yUzlzV3U2a1VE?=
 =?utf-8?B?Rm9lakh1UklsOW8xV3BOYUZDNW5HOCtuOG56K3R2TUZMT0RMUmRGQUdTck8v?=
 =?utf-8?B?NXlxcWtCelZnSGx6Tml0YkF1Q056bzdHTFExRUZlNVVXVERRelRVVmp6MjlU?=
 =?utf-8?B?K2lYMElkYXFwdUhzcDE4cXBoYXE5dFVpV2QyS0czTFk5RmFBTXFkNzJLSmF6?=
 =?utf-8?B?M3hWMWZuNU9CZXZyVlV1NUI5OGRlS21QYzExVGx2dlBOQTFpUCtZUWMxNERH?=
 =?utf-8?B?RndkamlKbjJTZTk2RmZqSmFBVjlOYVRiMEFqRElrTzlhbkJvdEVoOFF6MWZs?=
 =?utf-8?B?NHVNRGZXaXJoejdJVEFRWS9OMmU4MWprdkxKS0pOSGFZaVNNNFBHZUM3Q3FK?=
 =?utf-8?B?QllnSCtFM3FDMzBqUHkvZDhOYlpvMFc3bGxIRW1QS09QbkNLLzZ6YXdRRWxq?=
 =?utf-8?B?RTRRQzV0T0E3NGExaWJVVnhwQU5USVd0cjZDUDZmS2hlUXkvRzkzVmY1RGQr?=
 =?utf-8?B?TGtEYkZuYTlIT3dHdDlPWUNhTGdNdTRXY1FiRW9zUWxJblNBRGxadExGaHdZ?=
 =?utf-8?B?ZUtMendyWUs3ZUV1OUcyTTJmYlp4M3hCSE1xbzgzcDBHazZrdGxyRU1UeW5o?=
 =?utf-8?B?YjJ1a1VlU0x1cDFvaHNhUGVzT0YzTnQ2RDdPSkRFWUR5cjFSaXRHWExObUVw?=
 =?utf-8?B?VWgwN004RzdwYlNsSmEvZlYyekE0OTZScWJXWU9jdlhMZ0d1bDlEb3E4aW1X?=
 =?utf-8?B?ZitaZnpQSmd0YnVLY0VnMjBFRExKd0ljZTBuRGtaZk5kYyttTmQyMUkvdkRC?=
 =?utf-8?B?MzFKSS9zVytHUnFjejFPbllkSGNmTFpGOHg2Z0RFdWM0TzBVbklub3N4WG9r?=
 =?utf-8?B?QWx1SXlQYlMrMmNQK3FQY2RQcG82bzV5N3c1MVBqdStOeE5UUCtGeHBIWDlY?=
 =?utf-8?B?bE9FaGtiUURZNmgxR0ZxZjlFR01GZVJJZlU1TTFUdjM4cG5uY2hqMCtLb0Zl?=
 =?utf-8?B?Z1dXYXk2WFg5cU80Y1V4OG1LVnIyUGxBQ081QU5TOE4xV1NRUmpTYVdTSUVR?=
 =?utf-8?B?aDBxZ00vQUFJM01ScjNEUGJaNnhiSzBZTGlFMzRCdHk1WXZlZitXbXJCQU9H?=
 =?utf-8?B?RHg3UTd6OUFnWWozeG9jWkpVY1AxVGVKdGJCQzNsMS9wdE9idGFJbWhTZWIx?=
 =?utf-8?B?MG04TmlSUGwyWC9ybXVSM2M3S0llSzVyZmF3UnltUVpBQW5Tbnl5MkRnenhn?=
 =?utf-8?B?ZmdqQlZyVWN5RktjTUNNRENHU3c0eXVmNGswU3RxQmtzbXNYaFFqN3VTUGVo?=
 =?utf-8?B?bEJ5Zzd5RURkWVJhMElSc1JRLzY0SFFOWHhtQmtHWURyNkdpQmhBV3JLVm1C?=
 =?utf-8?B?TGdELzdlYmZyUjNYMnZEYjVza1BlU1h5WEtpYnpQZlVTMkdLck1LYXhDbDlz?=
 =?utf-8?B?ZTJtQWZDRXdEbE9nbnlnTnZVQ0NDQUtiNG5pYUg1UVVvY2dpemQvUDlvK0Y5?=
 =?utf-8?Q?fjR12cQNAKxKaOxue1mrzvQWb?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2e2b57-646d-4807-9c00-08dbc04e21ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:10:01.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR09MB11157
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------ms000306000007010802040400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/23 11:48, Orion Poplawski wrote:
> I have seen some weird NFS issues in my days, but this one may top them all. 
> I have one EL9 client connecting to an EL7 server where I'm seeing random
> access issues:
> 
> $ wc -l scipy39-intel-*
>    454 scipy39-intel-qcomp1.1
> wc: scipy39-intel-qcomp2: Operation not permitted
>    363 scipy39-intel-smmic1
>    365 scipy39-intel-smmic1.1
>   1182 total
> $ wc -l scipy39-intel-*
>    454 scipy39-intel-qcomp1.1
>    435 scipy39-intel-qcomp2
>    363 scipy39-intel-smmic1
>    365 scipy39-intel-smmic1.1

I (re-)discovered the source of these errors - BitDefender onaccess scanning.
Sorry for the noise.

-- 
Orion Poplawski
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms000306000007010802040400
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CmMwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggVGMIIELqADAgECAhEAyiICIp1F+xAAAAAATDn2WDANBgkqhkiG9w0B
AQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsT
MHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0G
A1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAy
IENsaWVudCBDQTAeFw0yMDEyMTQyMDQzMDlaFw0yMzEyMTUyMTEzMDhaMIGTMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEmMCQGA1UEChMd
Tm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9uIFBvcGxhd3Nr
aTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAxBJrIv9eGtrQLaU9pIGsIGBTiW0vZIYmz+5Eoa69sj6t6QANvg0IuVgWZajH
2fu8R+7m/AbZ8Wsuzz+ovtDHiVqUGvGzYyN9a5Ssx94SwNp9zLPfdCRMdh3zJB7gc4GYE/fA
kMkieO8u05f/hSyf9zU5gpjl7SW6p8IjkoyxNOr7KCbI4CQ3+1LG8pn6tz/QJwQ/BJZa4dE0
asXfNlZf5kZtyWtJhwub76zH5uXeODDxY3RooWj1l4V2fQCoFX2ov1ENUW4hRov1cMAD2QHJ
KL0Boir36wISvzq8Z65MSMCGNRiWwRaclVwVZ+QYnlhGZ0g6tMvxVrK+sHnxxr/LOwIDAQAB
o4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cu
ZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0
OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5u
ZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaA
FAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSpChQTknhqMfb9Exia9G14q4j9ZzAJ
BgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQA15stihwBRGI8nFvZZalsmOHR954D+vrOZ
7cC0kl9K+S9u8j/E5nZd+A6PTKoDpAEYmPUYpe45tZLblnvfJC0yovSIIMTo1z3mRzldHYAt
ttjShH+M6s3xrqDtHfNAwt3TCf6H83sEpBi6wtbALfkIjKuDitgkdZsyUURoeglaaqVRhi2L
5wOOChQAyfsumjT1Gzk9qRtiv8aXzWiLeVKhzRO7a6o0jSdg1skyYKx3SPbIU4po/aT2Ph7V
niN0oqJHI11Fg6BfAey12aj5Uy96ztotiZRQuhWZPOc4d3df2N8RsdWViBp4jXt2hQjNr0Kw
pUPWRO/PENBVS1Uo1oXfMYIEYjCCBF4CAQEwgbswgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
Ew1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29y
cG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4x
IjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7EAAAAABMOfZY
MA0GCWCGSAFlAwQCAQUAoIICdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzA5MjgxODA5NThaMC8GCSqGSIb3DQEJBDEiBCCinJwYE6D6kN8x56n5iNbu
W3sx4ad0VuXpPQK+iN5cRDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEALmyudX1jZfGAMtXV/o0wiuDyq3immySVsLDu/gT4xnin
ct05MstYcjvdC34tFbmd47xzGw3ClrEcSWueyUiQ8uysrGX0ij9kmP3GZJ52h4GFVeJ5xVMa
rHa6tpyp3taSILq+Ur0qwiPPe8AgiKL5DgfeZXtc3yUvN+XpkBJk09cdj09Pu716wWMZc6uh
jN82S39Z/ocmuz/D9QpDjZYY5GAfEFp+k/fpK+J8poaP4bgmGGJGyOxBD/I3ObSrqS2Se1PN
Ef0OhIw6uLC5umCcuMaFSyNxAJ8hskdvVNmo4uBjWr6j0iet1LTjuV9zqSpcOClNj9RtLFx+
HG29LEwbkQAAAAAAAA==

--------------ms000306000007010802040400--
