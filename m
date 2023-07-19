Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FF759650
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGSNND (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGSNMz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 09:12:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90932113
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 06:12:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JCwqgj026403;
        Wed, 19 Jul 2023 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XT/Z+rmkfZUjsZjoc9Ok75C1N64hPucgZTL0EtAs0Cs=;
 b=vDJHWkX6JpayPWtrwH3xWpuB27N+QXhzl9b5dgWMSLrGbH+eILZX3nXf6pDi3KoDKp/1
 oknT05Ft1l2mwNZoj4F0fl1sbiAT1eEZdBaicxqkXsW1GMqSUYoebkWMXKOXPVnaCjJj
 zwE23Jm+5ytJ3hkOCxXETwLKWTr4L6iHs2Ushp5Pd+rHbmbsEVWCK4DmJyPbcFM5kNNT
 eI3Lw0IUbiUFkCoiTIQNNV7YOZx4NhT3cJ6s/dJS3up5dZRAbPcrZcqC/ZCNoSjqqq3P
 yty3p7tp2BNVNdb8kicu6AL4K1q+8pXD49Ojt/XRU5DL9t1/uoe/9ZPV/SE3rBNDZFYB vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a7fsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 13:12:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBYLxu038244;
        Wed, 19 Jul 2023 13:12:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6tkv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 13:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7qclgkb/t+DIkcQ+3ZRayiolwu4T/CS1UB1fVs+N1Zxrhx2h+ezB0eKmyYKDPa3/lA0JWt6O5uLtm4rpknguIhgFK1kjYXXcetNbA/LsfBkfgeh0wENffuetiuDXXv8INbf4sX9ofNuKQ84W77hSAF/QQB2HtcjPx7ZTcTVeyz5WplZE/x6SEg0C03hDiue8cVgIxsatLO38tRuTLxsE3ZYZ/RQvZHBrNqYkTDbrvQ8UX9BYktsS0CAGjNcDbYVUTcOrDvrIaZD0Uhy1pFonwF5RwfFGUaWrSzKTZKJe0TNOOT3kLfAEJ18uiX1CcqhjBGZ+YMYZ8WdCScZfAQITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT/Z+rmkfZUjsZjoc9Ok75C1N64hPucgZTL0EtAs0Cs=;
 b=EubPlguOaEbpqJYH4+QxRdNjyDQ3TdLM1kLKKNFIsN8C7yRQnOjFE65s5rOxmvMUm3fVWcBdshchAxN1aP9zYdIVy/AUpEY4cWpnfXuQEW5Ezwp/mMvLUzgIF3SZGb72V38tS/Jn7yOG7KL/je5jAWxgGWl0zFHJgoRN6cHg7yKNGsq9W//jrn0SxEAYAv9dITt3Blmxe45pbMi3ZWvLKDnK5rF/VPvBXuPldv6YMCNTA++xpDrXwBU7kCgqdKAJBKHK1fBtnOTQI+tbN8HGplixvsSTqXBVVwbCF6R9I9X3X90jPeLjYymuD5aixtAKL9fERkeP2HuBrCKOeTfkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT/Z+rmkfZUjsZjoc9Ok75C1N64hPucgZTL0EtAs0Cs=;
 b=YQxK3Oq05O+CXm6zmb7k95AkCpzDjvV4Jn7eRXJ36iLAWGnnV9eCD5yjke1Y9QPJL+jFHP9XQ0eAKlD+56br9BeJdw1bVmyDlyeGfYtq0k1V2RVbwscjlUgQkmxmEvmU/tk6OiYvXwYbSxPKe7Ii6rF0gXh4EKrSDZ2HOICChRY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:12:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:12:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Topic: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Index: Adm6QrZKr5eZOwInNUOTZRGHjk+s9Q==
Date:   Wed, 19 Jul 2023 13:12:47 +0000
Message-ID: <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228866.11075.18415964365983945832.stgit@noble.brown>
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>
In-Reply-To: <168972938409.11078.8409356274248659649@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4774:EE_
x-ms-office365-filtering-correlation-id: bd7330b4-24c1-4653-b5c1-08db8859d8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFjOg/2eY9iL5/iba5HBXQuWjtcNfWZfWV6NcYnSeFpyvvoENENcJdF8LTBNHt9I1r0MngbRZzCLFkrAc8REY/21rjsjB5U0EDhfTlmBHR3DnYjPB1+o51aO816nzlFeqzylZ59vvA2xtzKP+ndc5W31SjhNL0r+2wTgbnpM3VffACNfXSQRXiUa2EgHh7BZCKzTep9ho5OOjj8STdBq6vPcUjdj0MB3xnqM3fU6Ycr7BUMSsd25mhegREWQAfGgb/opFhA0xnuAQeDTlP7WZXKP0gAJBImXzt7U7RPHu0jVRJwY4rI8b2VpP3Z729/wFYC2KxKJyVzyTLmqWBaUt7CchfeGt1Yhh6x2KZjEXpexvj4AH6fQVwb5ccKF/FPA5ltt54TC+XCBGZgcupg0Ga+Od0SzCztZqmRMODAS3RaHLKT1X3PcSX74W8l+EVRb9XDnMXiVz7PNsRTD34L7A0fm9Pc79iZsahSJ9vJMlRfEebW4u/bfnAw6uTgEhTFxb4qedKgr5CBCm8KbAMknXxGJXzxHbfaxLaH1NUIMxJX/Ypppldl/aB+Ax8rVxSlIS0vMJf0TJ8Qy3D9UNqb7IvEu+HZzBA99oS3xV44riHDi2KH91DX9funMVbwopRw2pXxlBshew01oH0zuH50oqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(2906002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(4326008)(316002)(41300700001)(5660300002)(66446008)(64756008)(6512007)(6486002)(91956017)(53546011)(6506007)(26005)(186003)(36756003)(76116006)(478600001)(54906003)(71200400001)(83380400001)(2616005)(33656002)(122000001)(38070700005)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rYAudEU9nHKgyMc4v0kmfnw6jV49MFU+pMsDqt68/lPj5TjA8KEblmHbH3Xt?=
 =?us-ascii?Q?GLzMRhUnw3Wf8B/tytP9Q1kuRJ03ldIGu3ivLc5alwLTmqZPn7kWGDhuktO4?=
 =?us-ascii?Q?Syj0Op8JlEg/TgsuBbcpIrTBPXQeS3moXQzeLYLMgP59vMy+7KpsZ/Go1BsA?=
 =?us-ascii?Q?0jCdmt5Yv5AqqdcoYqvc9hMJ5FriLD1ekW8yb4tgJFLecK2csFSe3v91XiwV?=
 =?us-ascii?Q?GA8+Fu35Jtmx1f4jqViKuLK70NOL+eKAxeapVee8Ntpvz2a3iYP4RfDXFj8w?=
 =?us-ascii?Q?PSnv2G2NgGEzIBmJ1zzel2n6FD8W7UnbHjK93DC/tkorpi+DmLDKc1TcCRp7?=
 =?us-ascii?Q?LExANGnzabXSzsPSk4K0SfRKWuj3K9BedmWMhLkSH30AKTWiXkPb5jCE6HQi?=
 =?us-ascii?Q?zepgOrzUphdo/41Zlnn1/D3/R+2ZJ1PyugANgHxfjquUDKuNjRseind38anL?=
 =?us-ascii?Q?zMx4UgnBDtnmaqJANVvvOTmCiDlMirdOIaISUtbLb2Kt5BkVSw13WdeVs4QS?=
 =?us-ascii?Q?JyrrAiG5ZrHZAtrRLa7vd00v8Np4YXsUTR7Pzr+HtAsPDlBrTBJtuAwTjQq6?=
 =?us-ascii?Q?kYtXmOET6qjxbxbu9wtbqfeUJNjdmoiGxPygG4tOKfggnsNh6znBw+eSxco2?=
 =?us-ascii?Q?ZRen8EhQWqYSwnFomfCbqhOf2V/rCke3JlOJf4qCDhN1z7413ruRHi5kDTJt?=
 =?us-ascii?Q?2lAFyHMPd5dmzW0VawXIhtfjVKMCC9WCyPxhWKd761zh5QVZxkZky35PkkFl?=
 =?us-ascii?Q?PgQxl18RX3W+85QQmnGPaw5+2PdCXS2epPiSsUehXNnBnDs/m8+PFwy5JtoU?=
 =?us-ascii?Q?77ZWNaipb0P8ZTvM0zVKsqf2ml57NDrHyP62mPRsiYIce0G4/7kIilBmPG/v?=
 =?us-ascii?Q?LT7bZJjMhQspJ/0y5pbLkrAh0vnuainbOSkIPSF09Mg81p29sOb2jcEnRpl4?=
 =?us-ascii?Q?l0vOMzfSxTcUI700Q/hl3ThdvCkRS+tCpuj8fylUK14qP9UTZOrquA0JZSt5?=
 =?us-ascii?Q?Jl7Ra2+1/4sKfFwENG8XBia+UrlOi4oHHi165m+Dpybb+C0WcsKs+BlEbFjd?=
 =?us-ascii?Q?FkbJ5SaEcjmwnUiZhCqgz+eXGBwe9hcEO1bf8+AgBRK94W3GqENDcpa40Ib6?=
 =?us-ascii?Q?/AjfhcFCY/oi4RpQsTnEGjo8urL82mVlOyxhO3v3nga+0mpeG1RD+xf3Ts+d?=
 =?us-ascii?Q?ZZ/Rm6yitgLIftISmld7FBHHRpt3tN3xOlQ9QrI0/0AbXQltxV2AjxMtjGOJ?=
 =?us-ascii?Q?PKcKdsOdn2qZAT6pGnKeFDuoRKGXWJxNwEipDfqaggZ/LieThlcjffIML++P?=
 =?us-ascii?Q?PmkJt/aU8SD5yTdbM8z1++QIP1RUD9f+ZdKHgwEHcrRykSkcY3IfpRw0/K8P?=
 =?us-ascii?Q?IGOQiyLe9wod3NFvdlOUg0IPtJI916kNjabWBP3v7mXdopHDkD3N99dZrCuS?=
 =?us-ascii?Q?veD0gB0YBc4tCgN2cqefViDwoH+KlpdGV5m8n9vtdJbV4kk1koQvZ1Zo5lUD?=
 =?us-ascii?Q?s8kIPeiw/VNGL/vnJxskq3NermmBR/ups9XL4kDRoBUyzFzfBmEEdVJmQAa+?=
 =?us-ascii?Q?eBTQS/mkOqAO5Z3Qgsobz9M9H9sHF1PjiSNEVmBxSVQk4KGhaM5BN2MfCun4?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66D0634584685C4AB2DA82C036101979@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Xz6VEGZTjrXYGaLOTC8MD2o4hEmWt9WTZtj2Qcy0uWF4e8l2uhpP4kqxH0syj3QpAHoDzGRrCfe8ZSxxz2FlFTPIuDonPqpQBkqOV29DrB7BmjrJBXeTA0I+D/EwBd4cN7Qnz9djzjYGDqBW+TSRW4yiIMNM57XFfaksAFHAn9YXpnBAzmTYMMQo3+AUipFykPix98xwD2f4wlbFh7KQCyur1VplNon94scgumUWo5mUufu/3PFI9pNtNqvOSJJWIY5G0SR5jS/I6Excr+MLQRJA+patLJCmrZw3mAxs5UBEMgg140BoxuqUzXSHFjc952iEw1Z3Shy79xBAq2sKVniNdrlwgvju5pJc85igtOrraLE+u6375BT9pUolCMOybmwnoqqDznW0N4ls61KJQcfEZC2s09fzndcYQP1AxdM72cQb/VP0BC1Dt5U+8XG7sSG2BygRKRPkrRfXoV0u4DUMCrFx0cGKaDmMs2EGhjVZ1CJ4LmY0f+/e/QkxDsuz1ROQE79j+QdzF7/vJol8l81CTat7tFNQOYi2BgWtf/bBEdENIdcZ2SaKNWMnVB1NqfoXUUArC2TZu5T+yRZ1Tar2eoFTGcX2sVCG4CXjfIyt3ZpAbqCPZoyJo/ryIA8Wxkb9gIqVUO07nQV3uJlHGlcGrhFIoyXs1+ex0L+wlXm1WjWG2umBb7o3cfQKmCk418k9TLIrE7S6TCzO7F+0sTILjod97TxeP0AbuP4C5YJFij8QZdql8sQIz5M3dA7U7ObvSRvSlQxb1BruGXuO/c4hMAg0osR5fKBJAuWb8Zr7Oaxfc4OvwZGiBm2XzzZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7330b4-24c1-4653-b5c1-08db8859d8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:12:47.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al8sNbZYkpzk6K1N87cr/WV9+/lOMeeRjpX5pplIAot85Bgoc59i799mpNm12O7dNyJUDlpWFdSLC35va9ScnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190118
X-Proofpoint-GUID: qDwLfAsMIJ6Nih8Ed2nICOs6EsuCYHRx
X-Proofpoint-ORIG-GUID: qDwLfAsMIJ6Nih8Ed2nICOs6EsuCYHRx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 18 Jul 2023, Chuck Lever wrote:
>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>> No callers of svc_pool_wake_idle_thread() care which thread was woken -
>>> except one that wants to trace the wakeup.  For now we drop that
>>> tracepoint.
>>=20
>> That's an important tracepoint, IMO.
>>=20
>> It might be better to have svc_pool_wake_idle_thread() return void
>> right from it's introduction, and move the tracepoint into that
>> function. I can do that and respin if you agree.
>=20
> Mostly I agree.
>=20
> It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
> as there would be no code that can see both the trigger xprt, and the
> woken rqst.
>=20
> I also wonder if having the trace point when the wake-up is requested
> makes any sense, as there is no guarantee that thread with handle that
> xprt.
>=20
> Maybe the trace point should report when the xprt is dequeued.  i.e.
> maybe trace_svc_pool_awoken() should report the pid, and we could have
> trace_svc_xprt_enqueue() only report the xprt, not the rqst.

I'll come up with something that rearranges the tracepoints so that
svc_pool_wake_idle_thread() can return void.

svc_pool_wake_idle_thread() can save the waker's PID in svc_rqst
somewhere, for example. The dequeue tracepoint can then report that
(if it's still interesting when we're all done with this work).


--
Chuck Lever


