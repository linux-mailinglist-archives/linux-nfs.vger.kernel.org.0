Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D7570685
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGKPBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGKPBr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 11:01:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032C5D582
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 08:01:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BDoRcB006729
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 15:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Il8Bxi+G98VJB1XGWja8wJXWCvjXVfJjpJtS7XcAEis=;
 b=bpxzuzduK1/lr90+W5s1X0WAntlEne9SE0MtJaRVU0VO02qiWHrQJJTNmEe9txBZezF8
 NWQVO4f9LFP6lOo+msT+g2QcKVIv66TCB2K4JyPOfPfVhgr7UyjFIIj/w+dygdNWT26m
 PrcLHD0iO0Lc4ZMfx+DcmXy+gSSShxcFjuvDrOhInBQcVdnoZp37ebWvoARJ0N0fTq+v
 qeEHMVolK6uSu4fpjMt79q+cjR07iR4Uzc7zpCDVNu1+eJFZqsZ67bVKT00dUkyXZ2kF
 lwLjpHEBaZECU2Z7I2wDbiL3r6b3cDFEHXUnhPoB4h55vo2q+NmLe6cp93cokvS3cseD mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc3s94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 15:01:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BF1ZQk018307
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 15:01:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70429apn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 15:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnFGsHkZIZM1Fv+AbvWlt9kBWv1RGehOevipf7EGVUodV1X9K/gUx2bq/EsyqSSymTyetnTmcgj3uKEYAoRK+cPRHD1WhcYx3+OF2Jf52zebj5Te5mH4ZpOatIlCeqJWi52CuSTiycYEjkN2PQadcDSxKW0AmcZdEXl8jl9jj/kv1mKd++fAIHD29jlV88tEUOknNf5ZSPUlMpvAaBDhW67IWyKwdXbhcN/zU/y9Ayaw8w3JbuPeGnuBjvE6EjZiYQMeXnt1cXBrP9eQ9+MnWxdfi2CgV7oseuiURO7VC3pLDzoQKKmSX7SUA9v0DZLisX8nhAh4uiMAcl5QMXFFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il8Bxi+G98VJB1XGWja8wJXWCvjXVfJjpJtS7XcAEis=;
 b=M2aycNLyThtFTzRGb4vvK2hLjRJVKEiWh3UoyqQsXN0d5iOlr0OhvaFDwd4mkank4MPXuMhbk1qBbXnv5dR2inv+kSBszKH6eXO154jiJ5LXsFeGxvNIf5eIbrV5Mg/FzyVZUgdEwR8o+a2HSXZgIDcctQ2tdlfs0zVYKAGjpHGvSjF2dDtxTEsVhDp8apwTobMq6idStEAhmfs4EKTgF/QIx/fMyBi6l3LqwNebVXp5ES1nE/6fzqxsLxHC6M7eh0aJqnNyEfDOLfdx+/w+aBbJxnV7WgnFlU535HhpWisMRcpkr4CkbIWjoYJwIPOLVnl0Y9VueLZhld3wOlgG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il8Bxi+G98VJB1XGWja8wJXWCvjXVfJjpJtS7XcAEis=;
 b=L6yQyUYsR31u2TJ0Kp5u66qtSSomgLBuqVd7VIfPFELgTl/onMl1R7Q7gIz+YEC6B3/yWqk6wqhvlAdHEFhYV91NR1/vjSC4r+JC5Rm4KaRKRwJpNag4haFO51Tt/zRk6B8rS3NF78Z/qrSw7VRNPwsRC1pXJKxTuasplmnxvgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4070.namprd10.prod.outlook.com (2603:10b6:610:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 15:01:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 15:01:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2615RPsA
Date:   Mon, 11 Jul 2022 15:01:41 +0000
Message-ID: <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a83a0edc-bca7-4b8a-399c-08da634e4337
x-ms-traffictypediagnostic: CH2PR10MB4070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvEzm08QqAtZcnjoj0qyh6N4NfcWGoj7j7pYThe7SyaGMQ2SJKFr8ZRWMG+/BZdCUJiz5S5Cj2YuAjkAPOfiB9TukWginqYShiW/eE8eTVDVGNLhdoYW5cEco9vV9kZDC9VPbWNFH+uIvUyjB72Q1AQaEW/peoAPNS5OZTuYksXr3e9CZs3vRoWjZ8BAX3zyLmaUnCSI0IXaV2vxCH0Whe9e8Thcpmx1MBdrrax2JhxWzy5WS0/Vv4AJfQE76/cGo7K0q8mCoo10O0CNjkm1DfdkwtrOSq1ZHmLBKd1M/ERfLTO5q6vPgrfHqSakhAc+Q+5z5bd74fEWcfSFLYsfv/l6ysXfJ3xGOeweAIKAtjoXNZkhrKU3fvKckOSrUGg6Z342bBqFhflb41DiKif4AvME5vEQY0aWbijp+VnK3k3pdUq+7qKPRSt3TKjd7rnDiBMCvA3VYJe1r+ckGM9EfnovB4e4bz9KFm3A9z/vyaKwGn/mD/V5bC5JwZcjfl1nwa/HFCMT37C9J6ql98wyfSdXpKhOr7UDQ8q6UEel3h3wQ3excXO2UZ/qXbB9XUoeJAyH0H5mQlLsUcW1agrv8uuJq/1LPkIaxdrB0dOp6VJkEhyMcoitxnvTxN1p91Cq+k4HgMsJgSgXejK676TJlrXxjlix6D/6F4FkBTdBbUePIWqbIKX2tAm0P8VcYFT+hlj+KOAiA+YHeFYImkco1Ke9igfMmROJIb++MpD+d+9KjD0rXkLbch7RMGap5EyBrtPYlIoQ75moKo74Ml1wMxyrxCXFqXPSz3u35p6sldXdBcyv4XqwNfA10+bRjP9UBmQiiDuTX16mZDt9MZr/FKIe5A8EgBmNxp5qpM+TqtonaJ+oGUt0kZfjPjskIK8v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(122000001)(91956017)(478600001)(71200400001)(966005)(36756003)(86362001)(53546011)(41300700001)(6506007)(33656002)(76116006)(316002)(4326008)(8676002)(64756008)(66476007)(66946007)(2616005)(66556008)(66446008)(38100700002)(186003)(2906002)(26005)(6512007)(5660300002)(8936002)(6862004)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ki9e4VSOhXBkrDF8EeVpgFhggS4QaOPlEQ7UPXFWm8HV7EnI8tlM+Z3GLquy?=
 =?us-ascii?Q?+tbYxc8M3EDB2GxMlPH8sBm+e0oUOMS7o9sdYArcDpr9O8dnmRCqTd32fw/j?=
 =?us-ascii?Q?dtXaetAGQe3Ahuz2R1jDVvqYuxSDvOhL9jgDBu3N6MbCuiFeZCDoRF0EF+2X?=
 =?us-ascii?Q?r5FwmMsuVPxNi81P47Tin+heBpn9V8vWrXl/WzjFcSFlblBDk+ZduIHK1t1A?=
 =?us-ascii?Q?qsY7sI+u1k+sHB3MrlzSByGxalYZUx+CqyOX+hHqeiT0V/4w6fDLksEg8Hku?=
 =?us-ascii?Q?rqJedNwehIbiUe3s2plAdLpuUWbBPp6xEhCCRknN4n6EVKnml2S+qlZPILsq?=
 =?us-ascii?Q?OTohuLZfdDfbOD1AyGBsrl1qD1VgsQ33ZS0OiRoPdJzCPBzJa/0sfm8FxdRQ?=
 =?us-ascii?Q?ltI6K/fLLUFRrwWpS7NzcfmVzwkGIszrSO2fYTE9hHqd1alDA3qB81U0vHwg?=
 =?us-ascii?Q?jm1Et1ag4YNjZ1VftZU91Hzma7ta2kfqgIIa2qaFbkhRkW6pDOFFnCi665yf?=
 =?us-ascii?Q?fMfo4IGD5ZXZHbOSZ8wWFsSHWxdGPg1zf57k5Yjy5IEjXdEGILQXD+58S7jh?=
 =?us-ascii?Q?MdQEmQvPZpujQAmZ4LJF4035kT3KS3x8rbPtCiKplqjnqEJUuPQ3yCGj4dP4?=
 =?us-ascii?Q?sXrS9/nGujqV7D0kN99tKs5qIqdXB5ovm4MxdO42k5XSJByLtb4isrX+T+yF?=
 =?us-ascii?Q?vCJucYxsjFlcwe0Bq73Ld4/AfgIlGavJZLsr9im2aprLsKfSYw0AHasqO+lu?=
 =?us-ascii?Q?TCs0xXufQSMseU4jlfVRErErK+mf50sgAsyREvdozE7e/or+9a9jsOUy845U?=
 =?us-ascii?Q?inM27ZlPtc8yd8Cbf73LLMZn1fo7Cam7haogfKadq4/u/rsPluEGvez24Kap?=
 =?us-ascii?Q?wP5op48dz0tn35TGw/lCnrpVuGH9/9r96iyw3+7P+6N1yxQfooOvWefU/iWu?=
 =?us-ascii?Q?C2nMZ8lKaoMkL9/BLs0rsQmtL+gkSJU11hHb4PbxB25PH4hJOdIWwugqKfHC?=
 =?us-ascii?Q?SaGrU0b/itwZNAQmZ2JDvpMVwXJCY0prlUa1I9wP6ytsKG5J+COn/42P6dnD?=
 =?us-ascii?Q?d6U+9fsCuVTR1UiwzQQA58InOR3F13MWmGD6BVYH1G/fsna/6whD+GncV6v+?=
 =?us-ascii?Q?axcsNliKp4wf/rl1K2VjIQZ9wqAki69+o/opk7HsQ32p3TFeg62UAz1hLD47?=
 =?us-ascii?Q?xGfygSlPCULrGUKxEQ7Q/TI2HzBQUGnFUkBIC+u8KLkRNpbpwtfqQa4RWuM9?=
 =?us-ascii?Q?+2Yc/t333iwnNHT2Xa6IJ5ndixXXU49IAOfNqkeDEqcJno2ld6y/HwWedKat?=
 =?us-ascii?Q?IHIRsq//OJJ1bEwrZhaa6FLXy1NyMtbn9A5LBDBUUcSonJKemm5RzN2W48jV?=
 =?us-ascii?Q?wKp3ZtepFJ+9iFz7wWk4+zdVLABcqksNlNJF+BJqF5lDiHK3Z3EwpQTEyBOE?=
 =?us-ascii?Q?6N7RteCWm1PJnLamJdP0U2M596lX02opFGOG2cPpHaYLyxI6et9k/Nfr6RZO?=
 =?us-ascii?Q?i+ztePlqgoFVv3B3xIatc8DGtijG56MEzGpfK+bus40+VaRAlPO/r/lKy+/L?=
 =?us-ascii?Q?xQ7kP1ldcmhwzLgZBHkgGY/QmIiacBZ9unTdkFCb4GqibG70xIADimT1MEtm?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5ECEE5C04330B418DBDED0F485AFF6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83a0edc-bca7-4b8a-399c-08da634e4337
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 15:01:41.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4zd0XDK6+Hj7j6mE7f5O+CEATQBy+5Zd7Ufz2Q0kJf426l5JF3WQENFVHG5rXtvqEKJF8Cp+gjUPzZSTyLNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_19:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110064
X-Proofpoint-GUID: NzN_sD_LdDiatFWELQk0K3VqFezTybVn
X-Proofpoint-ORIG-GUID: NzN_sD_LdDiatFWELQk0K3VqFezTybVn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2022, at 6:10 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:
>=20
> Hi,
>=20
> I have been trying to improve the behaviour of the FreeBSD
> NFSv4.1/4.2 client when using the "intr" mount option.
>=20
> I have come up with the following scheme:
> - When RPCs are interrupted, mark the session slot as potentially bad.
> - When all session slots are marked potentially bad, do a
>  DestroySession (only op in RPC) to destroy the session.
> - When the server replies NFS4ERR_BAD_SESSION,
>   do a CreateSession (only op in RPC) to acquire a new session and
>   continue on.
>=20
> When testing against a Linux 5.15 server, the CreateSession
> succeeds, but returns the same sessionid as the old session.
> Then all subsequent RPCs get the NFS4ERR_BAD_SESSION reply.
> (The client repeatedly does CreateSession RPCs that reply NFS_OK,
> but always with the same sessionid as the destroyed one.)
>=20
> Here's what I see in the packet trace:
> (everything works normally until all session slots are marked
> potentially bad at packet# 14216)
> packet#    RPC
> 14216       DestroySession request for sessionid 2725cb62002ed418040...0
> 14302       DestroySession reply NFS_OK
> 14304       Getattr request (using above sessionid)
> 14305       Getattr reply NFS4ERR_BAD_SESSION
> 14306       CreateSession request
> *** Now here is where I see a problem...
> 14307       CreateSession reply NFS_OK with sessionid=20
>                 2725cb62002ed418040...0 (same as above)
> 14308       Getattr request (using above sessionid)
> 14309       Getattr reply NFS4ERR_BAD_SESSION
> - and then this just repeats...
> The whole packet trace can be found here, in case you are interested:
> https://people.freebsd.org/~rmacklem/linux.pcap
>=20
> It seems to me that a successful CreateSession should always return
> a new unique sessionid?

Hi Rick, thanks for the bug report.

CREATE_SESSION has a built-in reply cache to thwart replay attacks.
It can legitimately return the same sessionid as a previous request.
Granted, DESTROY_SESSION is supposed to wipe that reply cache...

I'd like to see if there's a test in pynfs that replicates or is close
to the series of operations in your trace so that I can reproduce on
my lab systems and watch it fail up close.


--
Chuck Lever



