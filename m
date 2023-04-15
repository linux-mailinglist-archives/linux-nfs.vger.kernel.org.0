Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3F6E32E1
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDORYk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDORYi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 13:24:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF22117
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 10:24:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FAfMtv027268;
        Sat, 15 Apr 2023 17:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RMqjGrL572Zdb1sgx2NcBZ1OtIN8mDsI89ZfKQrDer8=;
 b=zkCDkFouhrDJTeMpei/t4sXGjjliuR76MFc01Nb5hMvJAvn2Z+ZsjU24GPfgi9mYees1
 hFp3FUklg/qIFxnAefdJXLkJKlQeU4yYh3PGTPmVVRXrZFyPgoftaxKkpVeW+FEUuB0r
 MRscCTv3Vuxw/ZZOXP7mkTnPxbJPlZDikL/124e9ENDQg5TxdXCMKfTpm1qBIJDRwdXk
 rgRGF9hPG3taJxSosQDPg5kC0J3GLSeyqWpMgz/IOutJb/3akeEX6BkCyakorb3fkCwU
 pxEExSH+ufs6OyHrRlja8WB+QSsOv0FNA+UJO2/pXs1o14ZUHrIE/C6rHGp1/Usq0OWl /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc0ptt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 17:24:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33FD3MnC023063;
        Sat, 15 Apr 2023 17:24:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc2echt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 17:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGwNrkokhqZ7gpFzcbzGb7p8lob5hYXl4AGSNBClgqR0brTrLOSLOGQSbbaLvcfsmaXKZ0ekuUCvcekRl5KK8e/Kejl10XMsw40Eka6R2De+FBGrdkSBHv6fUdqIjzO3ShZBKiPhSF4/ruPWMs5aupf9Yq2DE+v7Dsch8JEhIBzfUzJkLxLWp5RaQgdalU7bW0xCagVTu4OWUd4lRRYMcRfNcmdjblhHZDPEl7otZZMBtG2PNi6KiIZs/DTZzs37HFQcBU/Xgl31+G/fpERSrzB/dpiR/AJrBL8uT4Ec5ZdL/jkIiUTg00vxr2BP2X9qWOUg5TlymE/hyNK6kiS3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMqjGrL572Zdb1sgx2NcBZ1OtIN8mDsI89ZfKQrDer8=;
 b=Jrunz9VsAlgfpGcSBIrCe2TptgAojiFsyVaJuAFAljX/FsfihiG/HRwDm2nSt4NRVxGLvDW0kwBz6fa8VxwbuUQ00yyw7ghZdbH39LhvWaVQPFLD1MfS9AIQ40G2HtiBBxBsuErihJ4yzKHqAcf4oBGgKRjyBKIvcHelGE1Q1bsLk98FJUavxFZlZZEqgtA2dtnU60O7Tg2axRw4nDkB06pAcUoLeKuJmN616uu9XNHpiLa6rnTqy7d6NVWwrFNVsT2P0J0myn5zeJEgUAw3JicgiXQ8oit00BCUyAuPFe7kMIAViZwlpQkeYy67G/RqEdT08ConAp1rrsZBzL57wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMqjGrL572Zdb1sgx2NcBZ1OtIN8mDsI89ZfKQrDer8=;
 b=a69MFLzvzhw1ZettB1OaNFtBhEOe3ylGZuau2zHcEkTUcGxC2+iMfEv8gVtMel5r94wHwu51b0OxM47H1n2ghI9n3wh5o/YwXo2rAnu90YD1LLaHt7BDG7ItX2TtXvg3mUDTKBTIlYN6yORd6hZuyol9tmUPoYEb0GimeAxaTdw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.46; Sat, 15 Apr
 2023 17:24:21 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%6]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 17:24:21 +0000
Message-ID: <054d240a-f4b4-5c7a-2476-e80edbfd8c61@oracle.com>
Date:   Sat, 15 Apr 2023 18:24:17 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>
Subject: Re: [PATCH v1 0/4] NFSD memory allocation optimizations
Content-Language: en-GB
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
References: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 gx3r8uLHNg==
Organization: Oracle
In-Reply-To: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fjisH93pn75qX8N00g0zkiW0"
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a293f38-dec7-4a18-a904-08db3dd6402e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTfgQ9az3Fm4uLQl+e6IE3o5e+XdE+ds7If6hdIVymOdsGsJPpIxwzNZUaumNWZCyPt62IHnTDP1GUWslAG5qjJZdAqcHYXlUhLxAxbgJUboa7Ri9jD7cv3VQasTsR6srRy+LjoZASK1ySyxQxDgT+EF5l7/gkOGttynG9ts4kvRB1h1ipmNwzGBsK7dfDI0RYU9W87sEgwXWCbVMk93zg+rV7Gi7eEMC66ncfDK2oJdkQQiich3ppxvGpGIDWcL3P4vP1fGm0npRa0c5o9RQR/SNwvgRWodsHWqjEADGljuCQ20fxAmeXSVCIVs8oAxCWzvMUd/wDcEf4XB8X4MO3c0nqS7nj9TRBwkDL79QqK8WFw993ztEMV0Vv7oM/HQ8I7qaXRkS1tQnvkXSjjxi9D0YM75rt3zKGGehlJDaNLt6S7uIIEO6XD2OtCnQeQaR5D8rSaYSujpnMi6ilVExfcnxvV67CFesMXwQ5/3KC87TluBhRKlP2kmDg/mc4ur/GbKxEN1YH3lK/bfRckV9bfyTDizIKlOlLsnemNBJ96SvYcybvo+G2ULCMLvWqh6hlGXXiKi4JJSIZyjE77uv4pZrgoNRp7QDGvxRew58RpPdWWnk/6AarwABAOQ1R2O3QmFxmmRzc1HbN0sS5ztuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(4326008)(38100700002)(66476007)(66556008)(66946007)(41300700001)(21480400003)(2616005)(83380400001)(8676002)(36916002)(33964004)(478600001)(8936002)(6666004)(6486002)(316002)(235185007)(5660300002)(44832011)(2906002)(31686004)(186003)(6506007)(53546011)(107886003)(26005)(6512007)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW1QS1NyYk05UU5BYk5jZkJHbjc3TGJXS2VJRUlrVDZuczcralQ1V01lREFT?=
 =?utf-8?B?dlZjYlRRODg4SW0xbmtlM3hjY2ZKT3owMkxjWnd0QzhudG5UWmlsbms4NFVw?=
 =?utf-8?B?S0JVc2lWOE5OUkEyYlhTM2xNQm83RVo2NHBDZ2FtcjFmRnJYRlRuck5uUUc1?=
 =?utf-8?B?eGtxd2JPMjQrMEFnUFcrM1BOYmNIZkJwblpOTW85VU9icndoTkZIdFB4Zzkr?=
 =?utf-8?B?SW1lbGEybUVpaU5BT1p2aXQ0UWVtQU1jc3dtbktmWEhJd0xDK1VzeGN6aVFs?=
 =?utf-8?B?cmozdTBUVVg5akVGUWxVTFRPOUlXeWFRUExhaTQ1aWl2OGxEemhxSFN6UHNE?=
 =?utf-8?B?eDJQV0lCbFpFMjVxZVBzckRkTDVUaDlPbE8wL0p4bjNNQS81UE5zcUdXUkFF?=
 =?utf-8?B?MUIrT0lPYXYyZ1ljV3dMMW1YR0djZWdDZXJlN0NHQVJSTE8xcXIvd21IZ3pD?=
 =?utf-8?B?VkZldU0wMTc2QWRvUEJqUEtzNDI5ZkhQZUpyaldXZzM5UENDMWtoVlV5QVky?=
 =?utf-8?B?UkJ4ZVRNeGNEYzlKcXpacDg0Vk4remErdThoWGlSMCswZHliUlYyVXZMWEpn?=
 =?utf-8?B?MVNTWnYrQ09WMjNzYW02SmpjU2tOdmRXY1BtOHpFT0FuZ0M4NzJab3cxbm41?=
 =?utf-8?B?UEEybWVYdDROS2E5SEVNTURIS2NTbmUxazFKMDhkdjNidjZOcUgyQ2RzT2tU?=
 =?utf-8?B?VkF1aGJlR0I0SEovVUxMRWFJaTVid0hyTkNhakhVWGJRRVdqSGxDc3QzWGFj?=
 =?utf-8?B?SDFHR1BGQ0dLT202M2x5NzA3Sk9yRUhIcG1hSnRKM3c0eEwrT1JVOExkYUtw?=
 =?utf-8?B?NXZ0Mk1Dc0JQMUxSeHJaQUVxT1VGUkcwQ0FwclNMdXQrVmdxL3pVeWNyUlQy?=
 =?utf-8?B?Y0h0VUV0N2o2UmhZeWZnazRXOXJmZUdPS3I2a2d3M0RCa0xYOVBURGJpeUt1?=
 =?utf-8?B?djVwM2IzV09iNDN0WlFYbjhCS2xSQUpQRGRxR2t1NDcxQjA4VVBSbUhGanRm?=
 =?utf-8?B?STg3M2xIeHNXd0pRd1A4cGFDT2lpNE9wOTM1MkJUdk5uSW5RUG94VDVJQ29k?=
 =?utf-8?B?N1k5Y0ptbnlNVGZPQjh1Rm9QRWNzRnZkY2s1YzEra3JiendrS200UEM2enpy?=
 =?utf-8?B?TWxwV25Od1RnSVFjNXhFajlvMnFVTFU5dXVQY3hGSFZvckhFdEJyR1RhVW1K?=
 =?utf-8?B?eDQvdXVBNjFXemdUZ2Uzdm1jVzYvUWs3a0NZM2lVTDRSWTB3KzVOVWV2S0NC?=
 =?utf-8?B?Q0Vwa0RhcVR1WnQ0SlZibXNHZHR5S0p6dnQyL2JqMUJCNmdBQjhwa3REYWxK?=
 =?utf-8?B?NTQvSS8xdUpuVGMyYnJrZzBIWUp6NmI5YjZHYisvQUlYT2Y3UVRzRTY1dnZ0?=
 =?utf-8?B?N08zSVNsSVVybWlUV3BkbnNVZUF2eG1xdkdhUlRkREVxSldnNU9QZSsraXFH?=
 =?utf-8?B?ZlhieVBheTc2b2F2MWNCR0JmNHpIenVjYncyUlhTSGU3c2ttd3BucUY5NURL?=
 =?utf-8?B?OXVzbE4rZ0hsVjk1M0x2d3JWc1F0YXhXVTM4eHpCM0hlcWtHVURlMHA3UGkx?=
 =?utf-8?B?WHhDblFUVHU4ekRGS2JJWjJMcXV5QllPdHMzbDc0dUg5MjlBdTJWRmxLRmQ0?=
 =?utf-8?B?MDZaSDFYclllRkZCSnRWU21ITUVVV0N3a2NFK3FEYyt4dHJyMis0QWhTT1k1?=
 =?utf-8?B?MTlvSVdLZG9iUUVQWm1XcHdtaDNybGdsaXlScXdKVU1VcThydUowSi9XSWxk?=
 =?utf-8?B?dnh2YzVLRk5TdllxSVFCTHNkYkVxWElIajVEak5yUUh6UDBNeUlxcGlOZTA0?=
 =?utf-8?B?ZlZZdUNLVHk3N3YyaUQ4TVZ5N3FJM2pYVXNlcXU5Wi9zUHVuQnlMWDd6TS90?=
 =?utf-8?B?QVIrMjRpdG00RDZtUWRmOVVCVW04cy9jemQwRnE0bmdaWW1oeUZPUnljS3JF?=
 =?utf-8?B?azlOeE9VM3JhQVhOYXpkRTBNSE9jeWVNOVdaL0REQVRZM29aYzR3T1ZCWWZV?=
 =?utf-8?B?aWJPT2xzdkVBRU5BSGdIM0Z2cEhMSktPd3NzdXpSOUw0blpOT25Jd04xdDIz?=
 =?utf-8?B?Y01yVWsrakhCV3gwU0RkNnd6SE5pMDJGTis1ZDhlb1AxWm1UZUxVeEM2VnMy?=
 =?utf-8?Q?Ul7iAI6bexrzlE4NuaqPPgvoE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J48Mhlbz5etyPZODBib+FbI1xkO/w2LtfJXgoqNDg9LUOgWJL0dZKIWgtOTJvraI4yvnWukvgIcFSdESlqT7y5b9iHKebaO7Mdj3wCGLv6HvPxMkVQxM8tUzwjKCqjaEfjIpIEYA6qh0fH1HY9qHi7J9S1KOvpX1dn4VcM5nTtt1TcEJUzF1i/fkcsLDeuVHLKk+MwTi9n8hci+/kezJWuz9Nou11HT4xMNeHKdDTtaL5yNRPHaooHKteFH4cXZMU0nweqKr6bArpw1gugiLDma3T2Ao2lBHMpD3U58r0+TSGGZGscY0wfYCsXcdgkW49pCCHmiBp7DvKaT8GqLINPjqKbV6kr0ZK8Yv2MIiyXhs2v/wMI7AecRaJv4Uv/J1FcMEZUD1BGTE1aC855x0obrIVEVGEESmCtePFFwp9F8Xbs+WiiTC5DW4GsYSYH8WwoG6xjK9PYAKrGYIbqACvzbRYIUvfwNgdYcZdIem0lYzFiUAop+Kbh6VHfgyVBRc4HHHp9tTEIDwbSYwE/NXokXJIC43B2HsaHZYEt3Tc1nXFcQnAtxu1z8XqraCM1pPW/HTsqJPuffWYnJBgpo/Bug8HM09oTTuO2C3z1e4KMCSPid6OVtbaTc63b7B1qqJZwtWtuJXCymYP3JZ95FZeyT8ep1vmsHymitErBJEnWE2HjUY9VvAHD0qLJkZbOrL2bv1c/MWt/bAEBUgp1gNuUZtZ+gocp0GNlBgJ5LCAubDOcyHdjHlC6gDRuHFD+MPfXvsNbN2+QRtX6BOJyaDRT9VGySJyYJqurFoT5W+NKWSYAjtzea6J6G6xXk2oI1I
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a293f38-dec7-4a18-a904-08db3dd6402e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 17:24:21.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvOLpZmm+OPRhU5iGwV7vjI/ahyNOTYLB9SLYjS/u334azb/woA/wj5uC0EtVEsfDjXUh/9UyE6Zwg4m7nCbeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150161
X-Proofpoint-GUID: vpTMq3wiyKfEx-8bsXFd3Kz9maORRjNK
X-Proofpoint-ORIG-GUID: vpTMq3wiyKfEx-8bsXFd3Kz9maORRjNK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------fjisH93pn75qX8N00g0zkiW0
Content-Type: multipart/mixed; boundary="------------rurQO0CJYkOqwppaeHKhR8nt";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
 linux-mm@kvack.org
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <054d240a-f4b4-5c7a-2476-e80edbfd8c61@oracle.com>
Subject: Re: [PATCH v1 0/4] NFSD memory allocation optimizations
References: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
In-Reply-To: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>

--------------rurQO0CJYkOqwppaeHKhR8nt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUvMDQvMjAyMyAxOjE3IGFtLCBDaHVjayBMZXZlciB3cm90ZToNCj4gSSd2ZSBmb3Vu
ZCBhIGZldyB3YXlzIHRvIG9wdGltaXplIHRoZSByZWxlYXNlIG9mIHBhZ2VzIGluIE5GU0Qu
DQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiBJJ20gYWJ1c2luZyB0aGUgcmVsZWFzZV9wYWdl
cygpIGFuZCBwYWdldmVjDQo+IEFQSXMuDQo+IA0KPiAtLS0NCj4gDQo+IENodWNrIExldmVy
ICg0KToNCj4gICAgICAgIFNVTlJQQzogUmVsb2NhdGUgc3ZjX2ZyZWVfcmVzX3BhZ2VzKCkN
Cj4gICAgICAgIFNVTlJQQzogQ29udmVydCBzdmNfeHBydF9yZWxlYXNlKCkgdG8gdGhlIHJl
bGVhc2VfcGFnZXMoKSBBUEkNCj4gICAgICAgIFNVTlJQQzogQ29udmVydCBzdmNfdGNwX3Jl
c3RvcmVfcGFnZXMoKSB0byB0aGUgcmVsZWFzZV9wYWdlcygpIEFQSQ0KPiAgICAgICAgU1VO
UlBDOiBCZSBldmVuIGxhemllciBhYm91dCByZWxlYXNpbmcgcGFnZXMNCj4gDQo+IA0KPiAg
IGluY2x1ZGUvbGludXgvc3VucnBjL3N2Yy5oIHwgMTIgKy0tLS0tLS0tLS0tDQo+ICAgbmV0
L3N1bnJwYy9zdmMuYyAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4g
ICBuZXQvc3VucnBjL3N2Y194cHJ0LmMgICAgICB8ICA1ICstLS0tDQo+ICAgbmV0L3N1bnJw
Yy9zdmNzb2NrLmMgICAgICAgfCAxMiArKysrKystLS0tLS0NCj4gICA0IGZpbGVzIGNoYW5n
ZWQsIDI5IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gQ2h1
Y2sgTGV2ZXINCj4gDQoNCkxvb2tzIGdvb2QgdG8gbWUsIENodWNrLg0KDQpSZXZpZXdlZC1i
eTogQ2FsdW0gTWFja2F5IDxjYWx1bS5tYWNrYXlAb3JhY2xlLmNvbT4NCg==

--------------rurQO0CJYkOqwppaeHKhR8nt--

--------------fjisH93pn75qX8N00g0zkiW0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQ63cEFAwAAAAAACgkQhSPvAG3BU+Ki
IxAAnftWT77/ytVzT9hSqSvmICbZ7wmtHaI9IQNhHjBRpGhL2MoAlUDEetoJrXYHAgShR36hvuBs
m80oQfqtnZ7aObsPuiOjsweZ792SnuaD62MhnJ/L2Hw8jKZrXK8f1U5M8xOwHVeNe/OGmacioOfx
utfqq3HvmgGsc06MwQHQg0h4l1xj6vmKsgJSiM5ugjeilGJFcmwuj0UwmBdwhFJjEaiJOjOe3JLw
kETB2g7ITp38adxK+zkd0V0mrSx91oaj2jf5K7g9j7RG2VFXqHlIZJRCAJpRU+o5mkPV2+7XSeB3
C4/qSGAnuBm3YSMMKPdSs7HekY82t5FvJa+np2USAmPf33R98nazX3vr3xwUaOt8s4ATRboT55/L
PmxboQLVQ6qnTQre3jElrkzlN6NSSuEPbWCvsMiUav2KLk/vv6lWGmuSr1KTiGchtBG68cGW/TQo
o43iFd7vgSV2naKnOU8xq0auiiI1mrX96/E2jMCEXyhj45a4VwBAwVPNu1gpG9VsYk1mUI0++cSf
L5pa0FaSoFzYvCVhr7iEiRBxoWldopBnC7ohRcL9cjagj0+sGKCSXnWF4pQh+x4w32WVPQ6R2klB
5ImLQv4r7ZrNqh2hGESuCdRz+W8oCV3TlCXcELoAM+8vKNdfU4/TBJvFwlH2/pl/ly4PbFzdhViI
Eik=
=IDNq
-----END PGP SIGNATURE-----

--------------fjisH93pn75qX8N00g0zkiW0--
