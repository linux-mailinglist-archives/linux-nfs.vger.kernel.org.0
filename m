Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341B5B3EA8
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIISOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiIISOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 14:14:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C03E1A8F
        for <linux-nfs@vger.kernel.org>; Fri,  9 Sep 2022 11:14:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289I4KBU007852;
        Fri, 9 Sep 2022 18:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TiGLlv4YXf37oyK+Q0QPM2Whc4ekukqfVZ/AZVvUmSo=;
 b=m9Dh16ck5v7L7mjZEMDwXmnorBL0h5zvsa8hEhZUV2a3lvmHXHnJGlOX9ZHGH/L4k6oO
 USC454FWz06YgwVXVJGAyssx2gQSCrf9m+QpGgL63O62c5x+4RT1oigxC/ivzp3hTxDZ
 mkWPFV4XzS9RgFCBygQSYLunfNKOYQvQzCagHSVY8iAc6ojLdh6ucFowprGc+QF0sqv5
 AWEXlJCk7RwafnsCzcXnU5UVopyQswBM7HfwwBQ7o+Hou5IraIKjshM9iHCtIWDTh1NV
 2vWfHf8R1uSaj0A6veGMH8yVPyhwgJvITSKLpVdH6Rvd8fMIin7VZReHOsvHR+MkpxiG Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1r3dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 18:13:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289FuOeT036985;
        Fri, 9 Sep 2022 18:13:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc8bmt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 18:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdwluXhQQiW4b0bSKAdD2uiLR11MEI1xafC0E4zsgME/fgZWSneCBeJ1bAa6JFj2i1RyWUFhmnWIATUmRV9IRK8DtQEH0iQOqWnJZWkz37npla+3SzeysgI9zz9zLUwOfL6xQSVEel843cCwYhvNm19WJdGPA7fECr94CNDi3J0kvrnpbdZe/b5byGkenAbdPMozQCMDsaGHi0+UN7UEUgrCG8/3W+6gCtimhoL491oEXOwzlWjY/x4Xgp3/KvMUSz5Z2cJfMfms6h7jUHRNC6bMISnfCh8B4ia3t4XKnuTtW3ICHBMM52N9PsEL+H1pTKCYmzSaMduR8ofSkQ+L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiGLlv4YXf37oyK+Q0QPM2Whc4ekukqfVZ/AZVvUmSo=;
 b=O9AcYrPlb9LZkspOiQ7tVav1c6jUydRHRjQk2OdDJUo6Hh6FNd0xAHZUyn3Fpwa7NuT5GZ9IW8ftBDa2UMKuCW25D8ZuZjV6vZASst0J4Dx01IMJ+gmGnfceZYZodvDWYBnXKmv1rmkS26jB2FEdytVwAAvbNOatvUU1z10S38guizKsQxZfXfJGqxwkiiG8SGcWCCbqitKan1O+MpiviOyI9+4c/cnpvxuaVKabm4lX/+YGEuxHEGEL9i0x1XKH34QEdDLOtnnl3BJZigz0VfO2MgcPLv5vKZA3mfPIjOWKR22LypSec3uy8k+wb3zEo2MjyZ6QndUOgAvmYpAYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiGLlv4YXf37oyK+Q0QPM2Whc4ekukqfVZ/AZVvUmSo=;
 b=Tvpe57GK5fORWy4yc2qWRpiyTVlTw9Dt23bJe4OkMcNMU8Aspe6sjXheKkU3mQ84OdtrkT/F+UdlwbiJA4VZ64cPtdwwwAPNGQtx6f5l4Ln0VgzL5MrBbTjK1jwUVVT3vsP6NgKZXrreq2kgE8dMnBroZT/OMjcTq+ePBW+nIWQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 18:13:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 18:13:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Topic: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Index: AQHYphKND+E8pLJojUWzV0V0pTRpEa2brg+AgDv1NQCAAABvgA==
Date:   Fri, 9 Sep 2022 18:13:55 +0000
Message-ID: <B0F27CBD-0D84-4293-B976-A120A60FA27E@oracle.com>
References: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
 <E146112C-33EE-4143-92F7-7515638301D7@oracle.com>
 <1557e8bb-1739-29a4-a04c-c62732cfc7c4@oracle.com>
In-Reply-To: <1557e8bb-1739-29a4-a04c-c62732cfc7c4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4782:EE_
x-ms-office365-filtering-correlation-id: 178a8a01-5cc5-45f1-4dd0-08da928f0f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 567gXaa5nZEuYvcu4ETGIbUW4ovRlnthNPcoE72UfAZ6QiV1VOrs+wBhvkKJFLkNFhbpz/3oE2Rud8jPbwLV/hI3ISgoi++oiehWdJwlI6g5+a8/Uq1Y7g00GC5ARBSVan9A72Wtp2PEIdldTNRy7ULwQVpoyp+vGb5FjcnRvgzwnPUDVBAIgAQgnTfjnk+hUIdRYumJKx81fruRaSe8+XWj6sIgZeAYwE/dyl9EvFgmA97VDoBBnSSNf8OAiMTaqS1zlJnAsNsv2VCAsVqpFnj6FtnUpPFb1kRHbMVXeYpPTEsdK/5qY+vy9NYJKcFKymxHb4vBtv0gItU+sgBT4Nu2yQPH1rOZwSrUnxKkokWNyMvk3D5bDMXarRM3vAcoTRrJM1iKgDzkFEuGTW+MgOq1dwmJ4PmlYQIzk+1Cz5SFR9N+CSnD5dDRp4osdcC4BYpUBkF8wwJfkAlNPaHkf6iUAbJ+WpEpyvvIrcJ2mwKSToknrC3fGn9G5uCQEtYv/YX4i9ZEDp9tRK+fGzrGtu1dy4iZZ+KMZkck9nrjFoAn/0BTq90p5pxcvpaBof8Fn1CRcZT47ovhNzAE1e3mFdZKh3e606ljul8Xer1YGkV3Ceqlr2jmCc5Os/5SRx5vVgSyeFOJfFpSYeX2nqU/2ye4Gyj0N4g/eEj/oUnHfxYawa+SD4rVVjIoaZ4nevlqwk/bZV5uQH3v3+GUZIISlNLVYLoLwbIpM78n7WQxg58q/ossJQMjA+3EWWMbuTk3VcoGtgZsteXzR+Yn5a8YFJqhogpbe1pXGrDhNyjpo48qTmYbSpSlEtylx8MCuxSMR+SjrNhZDi36U+rTAuJeqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39860400002)(6506007)(122000001)(2616005)(186003)(6512007)(26005)(53546011)(38100700002)(4326008)(66556008)(66946007)(64756008)(36756003)(66446008)(8936002)(5660300002)(6862004)(8676002)(91956017)(66476007)(76116006)(2906002)(33656002)(316002)(38070700005)(966005)(6486002)(86362001)(6636002)(478600001)(41300700001)(54906003)(37006003)(83380400001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jH6O9Oifs4t+GRiKanLc4RxBKRHAY0BK/r3GTWW2rhICl1Rwqfj2XjJNybVm?=
 =?us-ascii?Q?dOTz3AVTJq4pUw006pmXwV8/OaoxwpTEkNVC6AuOoIHJRGEO4kCT8ydPlp9i?=
 =?us-ascii?Q?SysW4GmECdkcAJUlcwvrFSzenU9J+8jz1yRrXCIguowOzw9qFGFH9xTBqhOS?=
 =?us-ascii?Q?IFw4Sz07xJez+Yx/dVIQ9yA3q06GH9zUpSj2Ih76Mw3IyDMmiM0hlBYbkZKd?=
 =?us-ascii?Q?ncehT9hYAtFX+urSCxm3DB7+VJYE131f3ZA8Bz8YvKw38Qof0iIKx84flaLL?=
 =?us-ascii?Q?mWXjpVZlAL1Kx3FVuiPvRAVpRIVwK73X03UPi/6l+WsbzxF1e0EMnzHFb/EF?=
 =?us-ascii?Q?/ZeTPHKdxirl4gvL9a6/rUzB8MtUiDABL6H8LvwUlmhcZTxIyH2oCC7URXE8?=
 =?us-ascii?Q?ivspdnGm1iEEwgVY7FLfVwmIUxRHToE8vsqRDEL2JnfEF0KsDcZThVoIzG9u?=
 =?us-ascii?Q?ZgZJFvD0zwg4OCyHjAZ1mbuonRiGJlUxbV4lHeAZzTl0236lcKVpgfs/Ckle?=
 =?us-ascii?Q?HrIHpYcC5e6+j5z6LUr5L6mM5Lkkv/dRSEgEyrKwVYVEFnL0fRZceqg0yTyF?=
 =?us-ascii?Q?omPpKKW/rTNBbkcOLlJYyKSAkeL7dq4xmDj0uT0gifraTRSeM1cycHn85bQr?=
 =?us-ascii?Q?5+FHvwFKTdC7WYcOTBoZuph16ISyM93WytNAsi2emoSAH984jab+UPEvbNRR?=
 =?us-ascii?Q?8zuL0Qf1+9S0czJjtRjZ/piEyIl7G4+rRCWfMCBCoyMze1krHL8FnlWDb6h2?=
 =?us-ascii?Q?kdN5w/X1h0+owfBYCGAbX25fKxk0zH6STLgQ/eBv05IezWJnw9b010NG4xyy?=
 =?us-ascii?Q?zfioxV3BQ4jtmpqVWblahGRjw6xftOXavKxf8919KyZPxXOLky2XPDlHmnBw?=
 =?us-ascii?Q?qsjsV+ls8CNYdxMHnbYdpfbXW+KzBnTLa8Tr2gi5J2MMozKBl+NlsmQxPGL/?=
 =?us-ascii?Q?XNalfmunMGYlm6Vs6znJaH2TwiZGIoUlsX1ckm997uXGhc4mHZ0Wx7L3EfwS?=
 =?us-ascii?Q?ynJZNarqxAIA+g1Qolw/VMizQeYGR4QVQAgCjeXt9S/GbTpIGHjq7shui52z?=
 =?us-ascii?Q?ozziX6S+FbspMqKs1LpMGlRN3CjOSqyaTW8H6Ll+ae4aSROZxPHFx9w0I4nd?=
 =?us-ascii?Q?S2eEwCtmS1gMcB9rNT58y/tKj7gCZhjLhC1SuTZch5tP/zdT4Y2X5KC70IIZ?=
 =?us-ascii?Q?eia7GIHelH/aoPPFx7VX43I5m/SoEcqSnhKIgx9K8vaMCjvJxtVYeN7BGKik?=
 =?us-ascii?Q?pl+BGPikyiTkIBAd3By43zs2jQqTDI9htqPXwsktJczeL5G6k1gIUMjCIWo1?=
 =?us-ascii?Q?5KcCQurg9/P1UBF0h8NG/CcdLcB1K7eDixPWINceqKdhviOpVpSRkDV+CH9z?=
 =?us-ascii?Q?eGY6Ne6/gog+UYT4J8yYiG7fsPIpOszWE3cGd7sWCCkfBvLL9TlotDDYaA0W?=
 =?us-ascii?Q?veu0TzcP93dYIcBuB30uUQOi1mxCPuDjoyMdfddV0jj9rizd+5FcmAxN54q0?=
 =?us-ascii?Q?QSxYFWpxxEJu6VAT+dhv6GE38SOEOOrL+oTRhHvySIM0yMGgyqEbIcDiUq5B?=
 =?us-ascii?Q?gTEcqw13tyo4CqeHmzUC1Wz9OcIITn1H5RlcYaKzfRev+OsuZBWhScJa0BqD?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85F7C25442644D4881C0FA05FEB30F57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178a8a01-5cc5-45f1-4dd0-08da928f0f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 18:13:55.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n97qNcEHkpnA2uuhFRioywouBcWXeVfzf59PFEuGlpnvusTvE8M8UKOqpz4UECbj/vCdPlAJpF/4y5ZjiDBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090065
X-Proofpoint-GUID: WLW6-Z7H0ODZYlvxFL9E7Q65V4JYIwlt
X-Proofpoint-ORIG-GUID: WLW6-Z7H0ODZYlvxFL9E7Q65V4JYIwlt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 9, 2022, at 2:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Chuck,
>=20
> Is there anything else you want me to do with this patch?

No. It's been pushed to NFSD for-next (6.1).

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Df=
or-next&id=3Dcdfdfe05ac91618d65d94b28fcbbd324bba3c5bd


> Thanks,
> -Dai
>=20
> On 8/2/22 7:35 AM, Chuck Lever III wrote:
>>=20
>>> On Aug 1, 2022, at 9:52 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Use-after-free occurred when the laundromat tried to free expired
>>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>>> copy completed. The sc_cp_list that the expired copy state was
>>> inserted on was already freed.
>>>=20
>>> When COPY completes, the Linux client normally sends LOCKU(lock_state x=
),
>>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server=
.
>>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>>=20
>>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>>> frees all lock states on its st_locks list without cleaning up the copy
>>> state on the sc_cp_list list. When the time the FREE_STATEID arrives th=
e
>>> server returns BAD_STATEID since the lock state was freed. This causes
>>> the use-after-free error to occur when the laundromat tries to free
>>> the expired cpntf_state.
>>>=20
>>> This patch adds a call to nfs4_free_cpntf_statelist in
>>> nfsd4_close_open_stateid to clean up the copy state before calling
>>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> Applied to my private tree for testing.
>> I added "Cc: <stable@vger.kernel.org> # 5.6+".
>>=20
>>=20
>>> ---
>>> fs/nfsd/nfs4state.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 9409a0dc1b76..b99c545f93e4 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1049,6 +1049,9 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_s=
tateid(struct nfs4_client *clp)
>>>=20
>>> static void nfs4_free_deleg(struct nfs4_stid *stid)
>>> {
>>> +	struct nfs4_ol_stateid *stp =3D openlockstateid(stid);
>>> +
>>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>>> 	kmem_cache_free(deleg_slab, stid);
>>> 	atomic_long_dec(&num_delegations);
>>> }
>>> @@ -1463,6 +1466,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid=
 *stid)
>>> 	release_all_access(stp);
>>> 	if (stp->st_stateowner)
>>> 		nfs4_put_stateowner(stp->st_stateowner);
>>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>>> 	kmem_cache_free(stateid_slab, stid);
>>> }
>>>=20
>>> @@ -6608,6 +6612,7 @@ static void nfsd4_close_open_stateid(struct nfs4_=
ol_stateid *s)
>>> 	struct nfs4_client *clp =3D s->st_stid.sc_client;
>>> 	bool unhashed;
>>> 	LIST_HEAD(reaplist);
>>> +	struct nfs4_ol_stateid *stp;
>>>=20
>>> 	spin_lock(&clp->cl_lock);
>>> 	unhashed =3D unhash_open_stateid(s, &reaplist);
>>> @@ -6616,6 +6621,8 @@ static void nfsd4_close_open_stateid(struct nfs4_=
ol_stateid *s)
>>> 		if (unhashed)
>>> 			put_ol_stateid_locked(s, &reaplist);
>>> 		spin_unlock(&clp->cl_lock);
>>> +		list_for_each_entry(stp, &reaplist, st_locks)
>>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>> 		free_ol_stateid_reaplist(&reaplist);
>>> 	} else {
>>> 		spin_unlock(&clp->cl_lock);
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



