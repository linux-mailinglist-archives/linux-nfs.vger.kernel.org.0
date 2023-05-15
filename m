Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01471703C30
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbjEOSOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbjEOSNs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 14:13:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906D24296
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 11:10:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGo9M6028891;
        Mon, 15 May 2023 18:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xGNsP5wh+elkHxFuKb/l8iixNctjSd45mF+Aj76gbqA=;
 b=rqIrMjOb1U/qHV8JoIe+079COfZT3wTTPCTSNja0IQxf7Yep/SQ9USSqzr3DNtwVAD1w
 lvNm0gz/Lec0/05Pne3OjCnKRchBbQeBmJbQM2e+/byDqEepioir/sQmuHU/8n8BjroY
 CgJBbXOdFFW/7Cgadu0l4jykqr4k814BgCoEAa8XTO5S0aIsuxCckCQ0BumR79x1KJ1j
 A40qJjBALl1KeH4mDFW26TmzLnxp6iouDGUW1fH19ovOgcKbzjMJPGfJvt4NgV3GnQ+z
 6xV7UJLvwEUgzwF3MszZezyu7KC4Y5g+c78FhF6qvu0kx8yYdi75oNl7aHXYO/XLuXNp Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb0bw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:10:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGpGJW036759;
        Mon, 15 May 2023 18:10:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1098vq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+NaDMCjCdld+33racQ79oRagSVUG4dVQ1VB2JSqK+P5mMMS4Gr9VKb+o4K5LW+3LJMesI4AEXC0NmAeXLuo4gERu2B5dQu+pgr9gPGM3QYIWLd1MRyzYRlsGVp9qydXxXRhF0fwo8qMUa+IczzsOGEw7uWLqUypwA7XSIRXq86pBvtmmNE+7biR5i0F17LxOhoBbzKJjJxLBu51HnWOLf6g+i8/oF+ndND4eebVFT2RsqOgrjT8hgzdhSFIW+DYMFW8RTjcjMf+CesiEaZ9qTwd129ioLS+SxszhjYfpxv0UNFxwMhEZmtS3q8z+/6JFyRoSkWN1R6uXwDmDDtG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGNsP5wh+elkHxFuKb/l8iixNctjSd45mF+Aj76gbqA=;
 b=cgCsvP1DAYPrNza5vVTrdn89CdAY9kE6xgQ1EJ8vF7nts2JUWyi9TDc+Phz6wucxN6wCjpz4lugSaMWLZJFmOdy23sumBrseXeZbb7uSOj/xB5TsAIq+7D2K0LJCpIYz9wz5a52xmbt2bcQdgDmK1rhamfq6OmIjW7hdBU1mXdqABHL4ncNgb/4PsY26AfD93xrezGtgsZQq/OfEGdZxiyqqo3Boi4zVPACGwvGhsBj2zcp3UV3IuLgzvQEzqi3TJrQgBa9Oo9ywNnP3m/AsaC5qg9li+bRqStDdxX0GYeJj7Xb9yao+muSNH7T6Zo0CtXx/SzGBfBq6Ynx0WNnV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGNsP5wh+elkHxFuKb/l8iixNctjSd45mF+Aj76gbqA=;
 b=qx6v+bAD9Jj+Sz6m1sRuql2pSCOAZN0wHXOwmUOvc/cxUJqcX/u6goUOstiQ01KQ9hRuR/u5XCQdETjZT0kKD2rE9HuCgPyZccVkm1XRACyObXBDwbJmq8Pyk6accNgt4EhcUyz6m2DAfnUVugZKWB1r4QiUtO0Je9R6wuhKzVw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:10:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:10:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Socket creation observability
Thread-Topic: [PATCH 0/4] Socket creation observability
Thread-Index: AQHZhzG71ldMfHI4BkuQ0pvalUd1Fq9bjh0AgAAUnAA=
Date:   Mon, 15 May 2023 18:10:50 +0000
Message-ID: <011A0193-FC9E-4073-935B-69E4F9349214@oracle.com>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
 <cad818127d6df4ebcc6e837def684ad381de83fe.camel@kernel.org>
In-Reply-To: <cad818127d6df4ebcc6e837def684ad381de83fe.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4413:EE_
x-ms-office365-filtering-correlation-id: 9caef46d-55e1-40af-a5c3-08db556fb725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtCO9/FiEwCCGRajwANxIMMs60qZIi0UCau+/B3EJmMo4Tqx9gT5XjrT8XA8XHu5yRkPVxPonTC4FCQN6CjLGD52fRmPh79r220COP3u1usY4voVTq7p3JOHjA7bfkEqnsNNj4fgPLchlzcThgLv5ZO1rET+kJhTh/qVGfQ1i657QiPkZVc0udSwn9hTEzf07m8Lezkc2AXxYELPP0hquDtqHKSodtOVBHof6Kb0KP+8IxumMRfz/VVRjmfWU6MgT5JC5VKUvrKjpIVDjICX1omIbcWjglDhDhi9ba/pc41EyZiF+NYlPW4hj+5RAwpIK51N96CChk5aOgObXBlB35+BgQxrprXuIXyxOBYBz8lB6vdOOEsRKfz1QYdJZmoZ/1UeH8Z7kN2ywUIRPkdswINcAEwgqOEM0Jfof+u3PrI+RAYnfbJeSU7Txmv1bJA6oSRbWxbdZyvAiglIzK0kPFKJ3e2+kDc6TrHd1Fg4xpdwWFMrqS39rhGOS0gok/ky0cFLLSL/YAu/wHWjv+wx8iLQ5iulPRTpEnXZ5hThj81uXFeBfZLYyuS4hCFeoRfdwUF3ohWCGEJVUDIER//KByXQwqdRw0r3mLCoultP6sdm8al5T+8Ci1Y/7hO8ifvCKPVEWUjOrHPjOllWYvNHiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(83380400001)(6506007)(26005)(2906002)(33656002)(6512007)(186003)(36756003)(2616005)(38070700005)(53546011)(966005)(86362001)(5660300002)(6486002)(71200400001)(8676002)(478600001)(54906003)(38100700002)(8936002)(41300700001)(91956017)(64756008)(66446008)(66476007)(316002)(122000001)(66946007)(6916009)(76116006)(66556008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOo6+NfRnI1qOkCvzTbwjZtTMUjLvyCdRZ5nMH6sd2TRnnjO9y/4KvmNovdN?=
 =?us-ascii?Q?RVohrO3MvTtsS0PVOq3J1ohOO94ZXvJy53ahcQqmtikoJB1yoTL3tspUCcgr?=
 =?us-ascii?Q?3J2R6t6zP1cYrsytRWy5vAeaa7ontRO77N7G1VQmKCqm2XI+3TmQO6RRgRAX?=
 =?us-ascii?Q?DS41W54IwlME4A7Ettl5Db07ZHRhgGK5/XjtGP74l3p9Gkiy6acTAdw+hTDK?=
 =?us-ascii?Q?3z2PEaIot7G/CjUU8YOmB5O6icbWbd1qc8PciH5Z7GrWd+DryN1ecBnDiDot?=
 =?us-ascii?Q?aGRIMKBF+Zx9gqzJGr92j/9upfkd6C0sb+Iwdhmt1d35/RFagfCuQgFfXd0+?=
 =?us-ascii?Q?vyvZph8Lh8+HbR6Egr18V9dFMDPlkLtiFvCHMCU5rxBEiuL+Lrftcv/a4AlY?=
 =?us-ascii?Q?2Vg2tdWA4DOCtGj9z8MSt1mSD7vVllmJ512Vq+oMYV1mdw8hxqP++jNLfXel?=
 =?us-ascii?Q?T438q8ikXeXR8LbGTBSEnflNuf3zvUSy6o5VEb8wkM/AeGItI2HHlvRO/qeJ?=
 =?us-ascii?Q?v911CDZtE9BNPQRnGCwO6QFxpKg9XGY9eTjg/G6IIIE1yg4VDod/TbfQPwoM?=
 =?us-ascii?Q?Hzs7oLomQVsTTVp6rsNs2TMrAdQpYYLgUjSrg8C8QNenJuzC2S3b5dteB6OW?=
 =?us-ascii?Q?+D3siMD7CKx3wKaxp5aRRtuz1jRKT0TyoQ/vA4PIA9MG+1+lub9nnX+N96VK?=
 =?us-ascii?Q?nEdtVHejKGHFzx8Lzgi8L46RL9fHjdh9MwTltwfNeKRoo336Npri+9BmLikJ?=
 =?us-ascii?Q?hCSEF+B9KCNWyIMit6chUUmc//FCY2OD96F3OafzRRmE+ibCkFM/GWEDtHLN?=
 =?us-ascii?Q?0948bjgTnifa29EgFkfhtVaQTfGVxik7NR2zwuc0hoGAiGQdb5aliCd6A4ef?=
 =?us-ascii?Q?3/skCNnETOE1FBGVVEB6DSpRo8NoOjzsjWDRhEKngKfSF2ItYK/zGR/Lmr+j?=
 =?us-ascii?Q?tGZxB68ncWJ7ME17LsPr7cbVnuVZBgVqQUgbg73+qaX6UopkOdI1BKGPneFf?=
 =?us-ascii?Q?3LbXvTmU4HedYsvf/nZZfFwWqUuq60/ota2O3Sp66T1W75ZiMtDFDj39aqzI?=
 =?us-ascii?Q?33F8+85hjm+3FU5yWFERI0krqSK+lPteHbHOEJlwf8/q9n1INy4LjONq4gk3?=
 =?us-ascii?Q?0Av77X6ARMbAgC9qy3+wDRVjcbQgxmqbCtsG2gorCOpKfr35qoEn4Ghuvb1X?=
 =?us-ascii?Q?kfsb5bjthIMbWiqa9Hxh124A+vfqMBGUMUMD3pdkwKjXzloz/FG55qevZpOC?=
 =?us-ascii?Q?D4PGAWNiDO64ndtgfVrrG0yVYeCC2UpRbvFNssUNYxuOSLiwM21xzpX+Nuqd?=
 =?us-ascii?Q?po0N01pW5DPny5F473IsdiJM9L+0u3/8fhAqOH2c8QBcLlOmRikov67PaBLC?=
 =?us-ascii?Q?7CWU4+FAIdbqDhpxJ8NwbtJSqovcmtCob5X+WtcnKurO1oEbWHOCASoCU1/6?=
 =?us-ascii?Q?1trZDIbxvq61yRM78KOdM7Wolk7MSD0i6681u/JtBLZscfkLMYOgfYNowjba?=
 =?us-ascii?Q?BPx6AParUH+HZ/Eix2BLP3AouKIlZgO0Rt5Oi8I1llDjq9pZbQjrwm5QPkbV?=
 =?us-ascii?Q?bhxNGr9hwIdrJ0EMcUmiUQQnH/dfbayyY9B9Jxk2Prt6nmWjko0ksyPu3MyT?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB27EE97AD12794D9E8031AF4E4B3978@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OWUJ02QrIY/O5rtkd+L0yB3PiWze7hi1yPcQppDUCgC4avpBnJBmEHm+ecaDCqHadrcjC86+54R5xjQ2QAVieEOVhVexCYdxdAlzp43t3SE8e0ncdUYsWRXBfuPF45mJKQ0HRsrinZ4Hkgk8mUYOrMtEfTmlM0IodrTLs1qI1vengsOCC/uSFtYoBsr+QR6OUjr6qOwmG0eV/yWSIGfogZHJxNqULdbWEetOJ59dWAmwNmdKVY4BjaSQPESyOw+7xXdDsrX5CNWHffIcmU1wyuULAZH2/Dg3XiJ/z8z79RZerjGIATZ5qf3dasw6KchJbFz377ORV0W/f2s9MEPSmig4pSG4f2lrPnQqeEP6qOXJ6QPCgwgkrNFhNRNJCwG4VEdvytduj6gUZDGAX38U6FoyRPIDDReamdfGIzO8pBt7QQPK5omcyAqsxBJF1fzPLe++o4Q83CrciIkykykpGOqRnjvPMVF4eDWzpy0Zc8kMe1leaPBOGOGPcIdS9KH7RnP/K9lqz1SttCLiK8Bv9aQg/kn7CZyjW1nN9V02tTgR3y9BrgO4wAVOpoZN81boPhi04Fy/eALlCklv8BBLPbc9AeVUeTSPAzQvfVhMaGQx+cujp4umg9/GeSyFZDFBGfDFjuCVQYkmjzuTULywBdi7EWY+2/T2Nzoa2CtmXuJwIDO+7en3lYIEO0uAWWjKl93ctNW1nr4bDEt/SE76F9dqGeIbOcftJSmxAk+fPnndNOEDrjmV9QcN98DmNDtmELdOECdJMComH75tRKeGEv8J9fpiaK8OlQgcntR+pnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caef46d-55e1-40af-a5c3-08db556fb725
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 18:10:50.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KJ0j9lZhBEvQNV3e8TN7OtuGISs1jNOrP5Num1VIJjmnaugdIBNv9uR7UDQRRFuiaJI84pQFafHVFwj5QmY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150153
X-Proofpoint-GUID: aTe0r0LLJP9jH8qmoLkyWoHujhfLQcc7
X-Proofpoint-ORIG-GUID: aTe0r0LLJP9jH8qmoLkyWoHujhfLQcc7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 15, 2023, at 12:56 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-05-15 at 09:32 -0400, Chuck Lever wrote:
>> This series updates observability around socket creation and
>> destruction to help troubleshoot issues such as:
>>=20
>> https://lore.kernel.org/linux-nfs/65AFD2EF-E5D3-4461-B23A-D294486D5F65@o=
racle.com/T/#t
>>=20
>> I plan to apply these to nfsd-next.
>>=20
>> ---
>>=20
>> Chuck Lever (4):
>>      SUNRPC: Fix an incorrect comment
>>      SUNRPC: Remove dprintk() in svc_handle_xprt()
>>      SUNRPC: Improve observability in svc_tcp_accept()
>>      SUNRPC: Trace struct svc_sock lifetime events
>>=20
>>=20
>> include/trace/events/sunrpc.h | 39 ++++++++++++++++++++++++-----------
>> net/sunrpc/svc_xprt.c         |  3 ---
>> net/sunrpc/svcsock.c          | 15 ++++++--------
>> 3 files changed, 33 insertions(+), 24 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> These all look fine to me. I had one nit about a conditional tracepoint,
> but your call on whether you want to respin it that way.

Great minds, and all that... I had considered it, but decided
it wasn't worth bothering. I appreciate your time and comments!


> Reviewed-by: Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


