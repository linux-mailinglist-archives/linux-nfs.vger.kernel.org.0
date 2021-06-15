Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE063A85DA
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhFOQBr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 12:01:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58032 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhFOQBS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 12:01:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FFpOZ9008113;
        Tue, 15 Jun 2021 15:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=RwtWItpFUJx1ojQbaprarUdapztBbAwlMIGuRNK9v2k=;
 b=bfyMzvwevPQeRqRP12erhCGDZ20GVCjYa1l/iCd1ENpxrycE+mfBgNYpaRSQuoCUyzc8
 vpCH+vWZfQt/IZAKN5U6Tamha3tTuSB+75+6lgv9jn8uf2huWtSH2tW/+B9mnl1e3Fzh
 6ccrtzYcChamZ+l3qjK63J694QJdozyOzrEgVnrBqy/QK0YisiLT9vPZXFzes9i+eNQp
 vmMFsJHIdVJjTurwSpLpCdfOXeooCqVcIAipLV4rj1x3xLdCUlMrFH3urxqBTeHFcJqT
 U9FLKk2waMyEUeJstXRla3wtWlXxnp9oV6iDka/QqtEX8m5cnnOvYac2nK6POI9V8yeW lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tjdrcc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 15:59:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FFoxlE094011;
        Tue, 15 Jun 2021 15:59:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3020.oracle.com with ESMTP id 396war24re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 15:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCR3eX5AnXrF0hxlP1wDdiAiGV+xNtm588VMeqiAgCZ2mhmMUmyp0d62qMxsNpzxhXv/zexYXstDThGzYYaOn/PEhIUZ3qxhcusWJ4swV7kNZhfbAP2bheDppMLpSJgmYZ4E/WNW6yx69eGDUxvw0CPdr3yVg8TE8OjeFzisqeQISFCA+s5EcIkR1bck4IVVZVyM1YaO7l5e/Q81PpLT3KvTJWgiQNmfBKs4fmpeXgpodHKfYf7TOeSuVpmHnPwJeF54myrIkygFWSDYjHv+jBUZncKFFI4Ll7BMEfApo1zzDARZ+wArBg60uQJ5sRTj4G5W2FSGv0n/qPy8AtVq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwtWItpFUJx1ojQbaprarUdapztBbAwlMIGuRNK9v2k=;
 b=ceulf6Y8DHSeIE8fvjgPH7WU1rT8KrL5N6MoGMpMq5M/HzUAOE85yjT0+iWE/8IoAbrytC5YO8IftPKygIQ+VWK0mng3UHqM658bxtd1v2Ntyd40q1CF2shp0Aq69bRUn1IB4F9hl9MuzYJb7W8UxmuwDPLHMewC1Qf/TIdR5RYJKeIEm9+f1Cb1FsOGZrKi9UQekfykFbvpD3ZHRKt1GnsZA6RszYTGJELplBwYdjmKH7/cOSHVl527vr6VTQAe+ta+8Ohxfu5oncsiv+D1tbFL7B4OSTbuBYyVxPabhYNrmUF+lClu3toKZeGKJc57D14ptI7mrx+fVrtsOh5Ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwtWItpFUJx1ojQbaprarUdapztBbAwlMIGuRNK9v2k=;
 b=Za85/Hp0z5Bg6m/VqrRP9QWBitT0Wpc66A63bQ2968/lwbr4+f4URWc9A0/mwWJRyghm/3nDbmM5WB8XXD+T4jjPC77ovbEAl4+ZEQvhc+D37V4thM0L8ZYrqCfBH696UzqH6RzAPQVGtIWXbicHXXmVcIR5Q9CeRiANgKvQx14=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 15:59:05 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e%7]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 15:59:05 +0000
Message-ID: <db762c42-a0db-7de5-2ff8-fdd27fde3098@oracle.com>
Date:   Tue, 15 Jun 2021 16:58:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Content-Language: en-GB
To:     "J. Bruce Fields" <bfields@fieldses.org>
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
 <20210615144724.GB11877@fieldses.org>
 <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
 <20210615155007.GD11877@fieldses.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
In-Reply-To: <20210615155007.GD11877@fieldses.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WQUpaOeTO0OT8peVI3tdvNB3"
X-Originating-IP: [90.247.86.106]
X-ClientProxiedBy: LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.86.106) by LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:188::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 15:59:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3f51f2-9051-44b4-4f51-08d9301680af
X-MS-TrafficTypeDiagnostic: BN0PR10MB5013:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB5013FE0055A44AF690FED2DBE7309@BN0PR10MB5013.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9w1ufwc6uCRDGEESMxGkdhV0N33m/mrnYSvlZx3A8OuY0UgP66Q6FMjLEhB84VEGFmkQdBrxR1MvOpaSDjP7GlzVcnzj3/B4IKxl8nhpxlajj6kJjKSgEDlWMDQHHhhYnx2Htpkm49UKvmUuEw9BFMgNVUIewRY6aTfo5JTM82cJkYInQTkT90xpE+vwq6u6yHRam2uTqkZj4Xzr6zF1CzJ5B2hyU/rSqzqwxafczWS7peZudji6TmEAtQxFle8f1sYoR4mqsvCgzpipAVNco+csyxHq8+A1WRHriqdj8uxjwIPxVENUSASgf7+tLsPYI3pzcTtCYNDgYMTn/7qf17vMaPaHqfp5/Ui3Wvw0e/PMxoxGp9+5jzmQxVE964nSxjd8AVgi+6qTVOJxy2sorHJvLexFnMYmG13o1HCQ8WZgjf2Txf2BaZH3hpmNSeQT4q+5yoJWd9wBGGgrT4wO1KYmdK1tqVfG9CLDQQbf6u4I33rlq/XmsyDT31mXJbpWMb0j8/vxcrGkc+Vq/GTHlQCRKC/KHhSvBsvYvRxf+AaHwKVX4Ux20qBPTF4Z5gFsFZZa0QW8p6e4TB22+Q+lXgaLYcO3xHvxezsmIEOnKFBQrBMRrhWRD6eTSzyKMB07MNwWEiSwRrmxtGy1YVDSxuZXu2dOgk/FgYk4kYDbYSWR3t9fVRsgb9cu/LX3HFk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(235185007)(16576012)(5660300002)(44832011)(83380400001)(6666004)(36756003)(45080400002)(316002)(6916009)(53546011)(54906003)(956004)(478600001)(2616005)(66946007)(31696002)(33964004)(21480400003)(36916002)(26005)(186003)(86362001)(38100700002)(2906002)(4326008)(8936002)(6486002)(31686004)(16526019)(8676002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxoeXlHRExzNDBjQlhMcnljVVk3TnpyS3ExVHZzZVFKWDFGaldzMzh4bmtH?=
 =?utf-8?B?d1A0eUFLVGN3Z3RGVnlBZEx4REZIWVVZTTZpYTBCTFZ3ZEV3NjAxY0VuaHVC?=
 =?utf-8?B?bTEzU0xGMW84SDdrQldOWTNHOWp6a3pmYVJ6VmV6RmwxRmo1Tk5yK2UrTWQy?=
 =?utf-8?B?NTVubTc4aVJKckQ4SUhBTnhBdk81L3kxVXdCdmlSRDVYVDlUbTNueFZzVXdj?=
 =?utf-8?B?TUl3a2tvVDRYeDlQaWJUVUtxOW8wdUhOTWQ3WDVWd3ZkbmxwQXFTckgvWE8v?=
 =?utf-8?B?THpJL1grTzRnMk9HaVdPTmU2UnhrT1JsNG5GRFYwSzNBYnhoMG1NR3VmWlE1?=
 =?utf-8?B?SXV1N3diaWdDMkxmVTRYZU15RTI5akNtcVIyRG9SOEgxSFJRUFROZXZFUE55?=
 =?utf-8?B?T3NvdGcyczdtRTdSVHN4a2M0OEJBUmN4YnZTN1hGZE5MUTZuVXd3eHB1R2Nx?=
 =?utf-8?B?VHVFd2ZGcmU3dU1IaUVRUEdjeWF4U2Z5R1VDdGRMeXRSc0t1T0RVZnZwck5U?=
 =?utf-8?B?NnRuWmk5UWg0dTY0M01xTnYrdDdiNHEyVVQ1dDlMdCtJaHU2VG5JVktvbDF1?=
 =?utf-8?B?WEpwOHNMTE8vRG9IM1ZkckcrQ2g2TlFTbUFxdEVLejFYeDBaYVVHSit2ZjVm?=
 =?utf-8?B?Y216ckVob2FaOUFKYk9pVEIvNXpXVXJyRVZlaWNTVFAxL0pJZ0F1dkwxWXpS?=
 =?utf-8?B?UHEyQXBXTDJiZytlbzRKcnpWT1pEcEFSRExzb1hjQ2RXMnFUaCtUdlIvY2tR?=
 =?utf-8?B?SXQ4U2VpUVdPSHgvK3p5Q2FSRjRORnNmeWpPbnNlVHppSlNKYU1hUDB5bWZ5?=
 =?utf-8?B?MzRQWFdaeTJ1SWdkWENaaXFyV0pVbnNQZWV3dWF5d1VVbVI2OVpUVVVYQjNx?=
 =?utf-8?B?d3NRZTYrVUtWRXdtRVpDY1IyVkpoTWwwRDFBU0ovVDdPaG05VlZlOVk3Mlhw?=
 =?utf-8?B?MUdpTWJqcGphaUJkOXN2TnpjMm9RcUQ1bGVsSWZjaVdBcXF4YWNCK1dNdytM?=
 =?utf-8?B?cFNVdWtNOGpHN0xrcVpkcjYyamtJTkNaSXpYMlh0SEg1RXlWbXl6OEN6ZVA0?=
 =?utf-8?B?cjRtVDRRbTJoV1VTeUVBeHJPVmZBNUQzU1FCaWp1bTI3cXpvMjNZV0JzVzBC?=
 =?utf-8?B?MjdWMVpBdVUzL01ZZ0FjZi9jckxCZ1JKbTZlMjk2SkhlV2Z6RlF3RHYybFBF?=
 =?utf-8?B?Si9VaFVrUVNXSlpxb0NmdkJuUWtHUS9kR2tVdUFDczF0eTVXV1I1bjRxQlM4?=
 =?utf-8?B?Qm1kQS9kV1NTM1YrSHMzUUZCZjlvQUtGY2I2MkJENzd2SXdaWjBGR2xvK1Mr?=
 =?utf-8?B?QmU0R21WVUdDYWRsOG5RWmNGb0NJSnRnbWhLRXE2VHJWK3NNSFBicy9zeXZH?=
 =?utf-8?B?ODVkS0lpWW5HTC9hVTdoZDVGZ2sxNEllZU81K1VhY0hQWDhBMmwveEFGeVll?=
 =?utf-8?B?eDNSSUpUQjdBSkpsYVc3R0FuN21PcFVTN29hQUhVSXk1OVpXMFhHSlVUeUxE?=
 =?utf-8?B?K3p6akpJUlBFbU9VK0EwaThDc2d1WGFhenNoNnRhOVY5VUtpMFRGeUhLanQ2?=
 =?utf-8?B?RmNsOXBxdWV6dGFxeWpIc1NQc0JYMmk5RWU3Ui9WNUlOdCt0MG9EV1h0RXNy?=
 =?utf-8?B?Nm8yamljSlY0enpUcUowOXhObnEzZUJGVDN4OEY1MWRuNmcxZUFQRjVtb3pJ?=
 =?utf-8?B?Qmk2eDZpdEF0K3pZTEt5OENxUGJZTlpSL25BUDZhbVgzbFI0U0Q5eUJJd3NG?=
 =?utf-8?Q?QeXwSRbnMTfuZswkcuN6Hu76FyQBvPjKzPbO2GB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3f51f2-9051-44b4-4f51-08d9301680af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:59:05.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vajynmSGviDPutxDTFSJTo1i6Y5FAYuJVapqmruheTJowSMD8vVlOkdK4v6JjmEbR2XWcxwYVtIZjQeZknXaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150099
X-Proofpoint-ORIG-GUID: pMUkvKHo6fXbzYWN5gJQP9ae_UPT2K0_
X-Proofpoint-GUID: pMUkvKHo6fXbzYWN5gJQP9ae_UPT2K0_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------WQUpaOeTO0OT8peVI3tdvNB3
Content-Type: multipart/mixed; boundary="------------cGwDVsRkuglUpe5zt6mLroRn";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "bfields@redhat.com" <bfields@redhat.com>
Message-ID: <db762c42-a0db-7de5-2ff8-fdd27fde3098@oracle.com>
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
 <20210615144724.GB11877@fieldses.org>
 <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
 <20210615155007.GD11877@fieldses.org>
In-Reply-To: <20210615155007.GD11877@fieldses.org>

--------------cGwDVsRkuglUpe5zt6mLroRn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUvMDYvMjAyMSA0OjUwIHBtLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+IE9uIFR1
ZSwgSnVuIDE1LCAyMDIxIGF0IDA0OjM4OjE1UE0gKzAxMDAsIENhbHVtIE1hY2theSB3cm90
ZToNCj4+IEkgd2Fzbid0IHF1aXRlIHN1cmUgb24gdGhlIHNlbWFudGljcyBvZiB0aG9zZSBj
YWxscy4NCj4+DQo+PiBXZSB3YW50IHdoYXQgYXBwZWFycyB0byB0aGUgc2VydmVyIHRvIGJl
IGEgbmV3IGNsaWVudCBjMiwgbm90IGEgbmV3DQo+PiBzZXNzaW9uIGZyb20gYW4gZXhpc3Rp
bmcgY2xpZW50IGMxLiBJIHdhc24ndCBzdXJlIHdoZXRoZXINCj4+IG5ld19jbGllbnRfc2Vz
c2lvbigpIHdvdWxkIGdpdmUgdXMgdGhhdD8NCj4gDQo+IFllcywgaXQgZ2V0cyB5b3UgYm90
aCBhIG5ldyBjbGllbnQgYW5kIGEgbmV3IHNlc3Npb24gZm9yIHRoYXQgY2xpZW50Lg0KPiBJ
dCBkb2VzIGFsbCB0aGUgc3R1ZmYgeW91IG5lZWQgdG8gZ2V0IGEgbmV3IGNsaWVudCB0aGF0
IHlvdSBjYW4gYWN0dWFsbHkNCj4gdXNlIGZvciBub3JtYWwgb3BlcmF0aW9ucywgc28gaXQg
c2hvdWxkIGJlIHRoZSBkZWZhdWx0IHVubGVzcyB5b3UgbmVlZA0KPiBmaW5lciBjb250cm9s
Lg0KDQpQZXJmZWN0LCB0aGFua3MgQnJ1Y2UuDQoNCkknbGwgdGVzdCB0aGF0LCBhbmQgc3Vi
bWl0IGEgbmV3IHBhdGNoIGZvciB0aGlzIGlzc3VlDQoNCg0KPiAoQWxzbywgKmV2ZW50dWFs
bHkqLCBJIHdhbnQgdG8gcG9ydCBhbGwgdGhlIDQuMCB0ZXN0cyB0byB0aGUgNC4xIGNvZGUN
Cj4gYW5kIGVsaW1pbmF0ZSB0aGUgc2VwYXJhdGUgNC4wLzQuMSBkaXJlY3Rvcmllcy4gIG5l
d19jbGllbnRfc2Vzc2lvbiB3aWxsDQo+IHRoZW4gZG8gZWl0aGVyIGV4Y2hhbmdlX2lkK2Ny
ZWF0ZV9zZXNzaW9uK3JlY2xhaW1fY29tcGxldGUgb3INCj4gc2V0Y2xpZW50aWQrc2V0Y2xp
ZW50X2NvbmZpcm0gZGVwZW5kaW5nIG9uIG1pbm9yIHZlcnNpb24uKQ0KPiANCj4gQW55d2F5
LCBzbyB0aGUgbmFtZXMgYXJlIHRvdGFsbHkgdW5oZWxwZnVsLiAgTWF5YmUgd2Ugc2hvdWxk
IHJlYW5tZQ0KPiBuZXdfY2xpZW50IHRvIGV4Y2hhbmdlX2lkIGFuZCBuZXdfY2xpZW50X3Nl
c3Npb24gdG8ganVzdCBuZXdfY2xpZW50Lg0KDQpzb3VuZHMgZ29vZC4NCg0KDQpjaGVlcnMs
DQpjYWx1bS4NCg==

--------------cGwDVsRkuglUpe5zt6mLroRn--

--------------WQUpaOeTO0OT8peVI3tdvNB3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDIzkMFAwAAAAAACgkQhSPvAG3BU+K8
UA//YQLMc/Q3epdmPcF7r+qpcua22rhyh6XBWrF4b8q5Bow/f53ZX5ntn5ob3URMzaUesS9ipgnU
kCMEyApBtculjPOLrLn0R38lNRv2dzSTSixlyhtwaVCE3tK2xgXgW57SUZ3MX9F2i9BRYE7hwOFf
Q9oyzHEsNmKhagVllekvIWveRltvVpuaSAJw1f63yphydj9uYc0Q5cQjE9HVu2RD5xz/c0uO7bQo
wjxbbYClR6BChi0zWhqYwKv/mMA5+m9Q+a2tKk3h0+e4Y/tiI+AlArkkLsnFAbc0j5IiTiu6O1aP
A089WLrp9le/T63nQmwmyKQi7Tkrk6AlEucAxDyl8UqePyUwd2dGAj/j0STf7doMVVQMhmYa5Hyx
ojIQDC7ytoDuE+PODhq/aED8xegkpmJIk31bVQpbqc1Sjctp8Gwo+A+XXiK+2nOsLDc88Br50gPy
3oZMHcff/Lt1rRA6gMO2AljA89t1B/kMfoxl7bhqnhcuyvwfgXNMZ7gq5vmaqAnQ4nolF4U+wHeh
CLqmDCkPllcdh/z8l45cYWgtgIP2MhAvcbPvskvKb59CjbAxPo+0qjXqc8vbEE9DKBOVw74J8WNF
93tXuFbcuSb8VP5IVlY031M3Ydkm+jCYiIME1kQgafWRW8V5n03baC8tv5NdiNGKLunEjCQkS8tL
8b8=
=hH96
-----END PGP SIGNATURE-----

--------------WQUpaOeTO0OT8peVI3tdvNB3--
