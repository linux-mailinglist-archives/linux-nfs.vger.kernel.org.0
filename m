Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7118762DE8D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiKQOpg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiKQOpX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 09:45:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FFB53
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:45:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHE4kmJ028278;
        Thu, 17 Nov 2022 14:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=puBI5kuFTdBeodzd4YVY5/PSuGYKQFDRNf03mqjMFlU=;
 b=f31HL2YyKv9NQsoSSCxjYyq4XP1oxGNby+8B+mMZVd1kHY8FkjuEv9jq6m5Hd3YBxxc1
 zqy5sShqh6XM0WY3SMVf2r1TYtsFQlfsGyxgnWolOkgVHFlJkLMrWOyuaNKt/hwK7cf9
 7J5/Cr30fHy6/Fb/sWo+8iTUfRR+jRZaURFF56jSoiwd5HP8l6K6MF5wcgXeaId3Kd9j
 inAfy/5YvYmhHpC+rzw3qU9gvidXChX6LCJ+luVmFbYoqg+Qft1PNJ2493NPfaeQYDBa
 vXSfK9R17B6i//iE5P++WLE2uKrR1O4s/RH6JUhossp1CG/X5fOgZ6WITFcHLDNoZFe6 Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yks4j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHEBOHd008713;
        Thu, 17 Nov 2022 14:45:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xffw8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fls6IGtPbLXAF2PKJb0MnPwKKIslhVCiWDm1SXm+EG6TvrlDI4aFd+aAgGRXJFOtIsd/7sjqeK1JPtMaOYuAmG3JArKgAZGQCIjMJURTV12erTIghJcIcyGBXDqvq+OYXF87eJpPOVlRwuTHSZaB4zsR85vlZoSpRxVDIrmozRa7ruAfPii+yKgWezBUp4SDWw3D6GfUog7DGRJSsCn7NcqueNM6O4NPhCEa9Soz55UtzV+UbeskcHFH92tFayPSQ0SnU1W8gbB4JQK91zNXyAxehhtElgduef35HiPjzqdTXxGsGQOFcjbdzvnSgqoOZWK1dLHmGCd5xXEWuVnzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puBI5kuFTdBeodzd4YVY5/PSuGYKQFDRNf03mqjMFlU=;
 b=YLSRwpZXtWr3FMt3yknIOaKzfLTwHp6qr4q0fdFVrvLZxDqDAsUNpTqKmyufUWDY8G6cTcPx+8QzVpfBkjKm+Wkhj8b44cwdKbUD9B+1PsdkN7wW/2Qtn3FHosgd2/2BTaO0E4jXsheSS5e1aBrDS1iiWcIhpQHJ0PoQg466GuMwhfQ9/CoEs2IVWvFbTfOD8Ridh/Oc3yy9FYY1q8eCzxFciYBHxEr5/aAN3rI4VYyGRaRiUBCHJtgV83ol/f6T6r8XZuQAvNcu6O8atwZk985I6I4/ssJKFl3OTGy0IdcZ6q87eodyl48n7ICCwTJnfiIYwNUaAaNrNHjsdVPO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puBI5kuFTdBeodzd4YVY5/PSuGYKQFDRNf03mqjMFlU=;
 b=oUmCO8D3q37ddRPZay6UD2tK43V3L8W/4T9S4797pXa2M4/ZMUkkt0hO5nu2KXribXG03Y7oHg69YMtVbH1GsbgqcBygdTyKiFTRBGg2VgpgGXqgPlqccF3FSMuh4abmqnBrtXfhxXtAJ0UtpU9lTk/0o77CQ9ipEUlcz7ly5Qw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 14:45:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 14:45:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] NFSD: add CB_RECALL_ANY tracepoints
Thread-Topic: [PATCH v5 4/4] NFSD: add CB_RECALL_ANY tracepoints
Thread-Index: AQHY+jb4qFY3nMgir0eCHrW4yufb265DMfqA
Date:   Thu, 17 Nov 2022 14:45:15 +0000
Message-ID: <D3D8A1E2-942A-4A5C-B938-160AD8DB25E8@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <1668656688-22507-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668656688-22507-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4426:EE_
x-ms-office365-filtering-correlation-id: 7fc9523b-8a70-45e8-51b2-08dac8aa56f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpPyic+nspDIEZJreHL6HcthS4zc25joIqYc12NaxtR4qm0SFGJFr03cxzFlCbiGrOUL7CkP9HAGYS1br7Ah4djlk0W5+1oHzDXCiL6kLZjoLmFrPtUwg8jPBnKJDH5GT+Pfph1P8vZ0rppxTie07SyRSld1PB7ArJ2EWuAXgJLsL3DEqgv7GmCxSS3WrOrX+HC/JflJ6KZfg/Sz/Ur6T+ObP/1gjwIF3/Jkv/qy7MNXR11Z5d2LiAbUVgCcfEJEyGfxSTVNbI5O2F2DOoXYECzbGghsGp/bBJt3bpqJDLLYItvbuEziFUkwDBWDAKERN4hjzTsLqVmjzhPPpGEZRXptwRMZ2q1nHhelCjcqOOPVo824LJl5+ulm42TkEMQlitiqSwfEsXs5dOuYX3kdABDaGvDI6e2rPV0B55i6gaSyq1te0yj5VBJ6wLuWDf5I1IAUdXpotZ80doujFTsEsgfTotvtBA7ogFxuf9PUzlS4G25ql1mxLVXP9ruSgab7bNfoxMrbH3JlPl9crIJhfGTfCoxq/kJsn6KvX3/TCE3+JDvhjjwCa3yhjkRfgUvzx6PkN19Q1feRv3AoEVPj8rK03q4f44lCJMqh+zdXhv7EWGb8kjOAX0A7myUbYW6Rs1W0lYIiF+m7Ji+USWLLYecnW5WgzjMjkOXAEEuilnfBJn2RRYKkKZymdPkyaCtd7gu+TN8odnAZb20hR/TkXjDZbmAm3/U4BLA2bzVUUlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(2906002)(36756003)(33656002)(91956017)(41300700001)(2616005)(76116006)(86362001)(8936002)(38100700002)(6506007)(37006003)(54906003)(122000001)(53546011)(6636002)(6512007)(38070700005)(26005)(6862004)(186003)(5660300002)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(66556008)(6486002)(316002)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HbFBR7zrljSX0lFrwirKCESx10ODved575tGZWIh2zn2e20jTA5rjEJCkpIy?=
 =?us-ascii?Q?AwwR+iyMd8Eeo4Oew1E5Q0Jst5lq8IRRK879wLTkx6fi+h/xpciAo9D1Mn/u?=
 =?us-ascii?Q?y1UpK+X51pzTfMDRxGaalK0TQcYgMGCK+drM/83+YQ8WRgC9QBGyn5fcpTk0?=
 =?us-ascii?Q?SkAODbCh/60oO5Vgi5U1937Z7Razy7CtKLPXTNZAIn5fCoxiTXi1dyiAcKHi?=
 =?us-ascii?Q?7KI7c3CdF2KxbrVv9FBjA0VT7mVnd7PiAa8AnSLNWVMLyTOe6W1Q1GGTccuf?=
 =?us-ascii?Q?RYoNjs0iZlPRyB417b/gQ/2uXQTZFb94OZkYRBchBjXMmltZUWl+6H3vlovn?=
 =?us-ascii?Q?8lfmqE+VxLhEgaKQwH6M6O0FWjBxOl77w00E4hfBmwMKvCc8c981PexvHQne?=
 =?us-ascii?Q?oYk+jbApd5h8KQEud4J8NT7RFGHkrc2sbU2ko+jBVmu2DndpMxzp3/8srdz6?=
 =?us-ascii?Q?OeZHxyasgCIQG9AsoIdn4efZiesbg8u9aiWvFKXIkvTPevxIfh9U6H931Dum?=
 =?us-ascii?Q?QxvZQl6Lfn5lsJzZN3OHMj75ZrJiu4ZW29/RXZ2/BWg/Vcj2mczg7/LNHscL?=
 =?us-ascii?Q?jkWaX2ckZse1A+ImTv8ggjinF75fcC+ve9Tvf8OFbq2RQcWnj56ZgeXTOKM2?=
 =?us-ascii?Q?DZ9mF6hbVytirnik3nOS6vcmy5wYInPtTF/2TxRsP4tWSd7Zde+O5WVdKfXX?=
 =?us-ascii?Q?nSlX24vHAvUtP5QEai2gT/t/IUt8+WLrSmAAWg9uNfd9qwLl3ryMQG5PEXNF?=
 =?us-ascii?Q?DojYJH6GGTQwsiRmLcd9/u3SxJklJP2o7hdYETHOYZk+twyN5XAdmQLzCUrK?=
 =?us-ascii?Q?rUz6PJUAJ/CZ25RmTvHGqT8aYc5VY8qOp5flNhUn/kreMrJtWzvgixG4NlwF?=
 =?us-ascii?Q?EnPeif9NFxkVnqrM0sLTt06LdfnFCCewGOHANz6aIzMGrg8togl5dhCKFNtO?=
 =?us-ascii?Q?C2LsE6W8Xci5AiTK33LbJfSVo5ZK00IPJHR4vJ6aDrws+7FQfbp+1plaSvLI?=
 =?us-ascii?Q?/MsIAPxIKarLaWcwgppfNvck+INd8CH3cJJuqsdUNhxbNrgnhOPBRS+3VWba?=
 =?us-ascii?Q?Iv5guArvBrCdl1DL89mjErZeyfLd73oAaIHiRkSULY8Tcg2XnPTMKn9scb9o?=
 =?us-ascii?Q?GWgF2UeC6a2cA9sZiE/q69FcFkpfW432xisNbYavTgXKTR4rJraec520UnNT?=
 =?us-ascii?Q?Jrnl4+JoWgiP33abm7SYgazArfJkequ1QMwIKvJHb1mD3NX+zr/8+PxSc00F?=
 =?us-ascii?Q?GQyZbUeUKd5P5O1GMjhYPybSSFLFcqCFOXUC1D93zshVWS6JjFj8vIP/6QGP?=
 =?us-ascii?Q?mtkDwPM3wofinij8dcXTFcgKpZGxkw7Cb0oPW+GSCJR/VUbXxpAIST7Jie8w?=
 =?us-ascii?Q?9r08VRW1DNwi0vr/zEB9mKlgi0HQCdskNEWe6g1mbquzr7+m//uTMKplyvy7?=
 =?us-ascii?Q?wrKO8vnhRDRPAvHYgPoZXd7GGEk40cbpQLLFXM5Z6//Q9ijVQFhXYC8KBHIJ?=
 =?us-ascii?Q?aURAz4JbLkcihIWkeoEUpYrBtuPbouqwRY100x6dhviAwCPvmVLd0aCV1jas?=
 =?us-ascii?Q?To2DNb+OZHK4WBNtPwuRMoAzY8Xtz0L56XpFXIglYsfw9eO9ltwvKpQNfv14?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CB503095745644584D66537E20E3BF7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jc/eWFEMpHzxBdUtVpQzkA2mtS5OSqUyp4gxwFLGYDw91uW5ht7mn9axWormEDkADaSjHuFuCAR9tZtRMBqRfKQqdCvj1/nE8w8/+od16CGkQjDUmwh2i7YQtxVvY2hxv5wGo8NOxcMztyJ2SDAKHdfBLMAts0wYA+rtfojm/AOhz2cBpUDVEDW1mSAtuQbh1DQlE13CmdFzmR8nHu/i6jsUBilJvGEjTN363B1+D1XQ3+fKD/lDufxkv1DVIq/zLfdG0h5eTqDjPo/bNlqFQL6vpWJJaSvBt3WG3BJxOYJX9w1KbF2zt8PrV1eh1bNHUmMxK6ny3VHcIpsDDLArr9hGF9ZfJsXWoY0pOEzUMMnjtMi2/5iuzb3V1KcbEe5MXvCDpIlYPn8XtiwL/sOXHIOSLJc63ZzwMmU+BCO0tgdtgbtO3sNI0uSL3IKVkawFgLSSqZNKkBh22z/CKGHCiqc26ELItvo2OTtCvW0sNb7ebNCd30AMigJe225F8JxKydrCDOXGG/+OuxXMQqJvYu2QSjAD8jGGwxVYNmvJ8TLsr5kU9llZbGRG1nWqkqlJvetbq/+5o0le0rPnrKEz6bcshvtB/dyiKLc9EiGI0o6hsr29KYWDlYZVy4Y0jtkbMZmlwZNRenZn4WsnA722JXZg4iqQbsoe07CU0PsSkzlTqQkkCpbjyVcXXxP4lz6lVKIdx7YXT+CP0TZq+KbEMlIxMxcIzJbLaCn2U2W6cWU57Ydtgp2Q59V/QoTJbZbb95mkZ1oEcJ70jz9KZUtD5saafkFlVkBQuLzxEQQxOuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc9523b-8a70-45e8-51b2-08dac8aa56f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 14:45:15.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROX8dxILtaLh4OXI4MdFI/6AK/anWYCi1SknaW9vFbQYcawl9X/j6frYdjjWSwbgGIVP34Yc9scRxuc0wKD/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170111
X-Proofpoint-GUID: 9ECgga5WJ7hcv4gQ0Wu5CmnA83DWSF-0
X-Proofpoint-ORIG-GUID: 9ECgga5WJ7hcv4gQ0Wu5CmnA83DWSF-0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c |  2 ++
> fs/nfsd/trace.h     | 49 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
> 2 files changed, 51 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 13f326ae928c..935d669e2526 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2859,6 +2859,7 @@ static int
> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> 				struct rpc_task *task)
> {
> +	trace_nfsd_cb_recall_any_done(cb, task);
> 	switch (task->tk_status) {
> 	case -NFS4ERR_DELAY:
> 		rpc_delay(task, 2 * HZ);
> @@ -6209,6 +6210,7 @@ deleg_reaper(struct nfsd_net *nn)
> 		clp->cl_ra->ra_keep =3D 0;
> 		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> +		trace_nfsd_cb_recall_any(clp->cl_ra);
> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> 	}
> }
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 06a96e955bd0..bee951c335f1 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -9,9 +9,11 @@
> #define _NFSD_TRACE_H
>=20
> #include <linux/tracepoint.h>
> +#include <linux/sunrpc/xprt.h>
>=20
> #include "export.h"
> #include "nfsfh.h"
> +#include "xdr4.h"
>=20
> #define NFSD_TRACE_PROC_RES_FIELDS \
> 		__field(unsigned int, netns_ino) \
> @@ -1471,6 +1473,53 @@ TRACE_EVENT(nfsd_cb_offload,
> 		__entry->fh_hash, __entry->count, __entry->status)
> );
>=20
> +TRACE_EVENT(nfsd_cb_recall_any,
> +	TP_PROTO(
> +		const struct nfsd4_cb_recall_any *ra
> +	),
> +	TP_ARGS(ra),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__field(u32, ra_keep)
> +		__field(u32, ra_bmval)
> +		__sockaddr(addr, sizeof(struct sockaddr_storage))
> +	),
> +	TP_fast_assign(
> +		__entry->cl_boot =3D ra->ra_cb.cb_clp->cl_clientid.cl_boot;
> +		__entry->cl_id =3D ra->ra_cb.cb_clp->cl_clientid.cl_id;
> +		__entry->ra_keep =3D ra->ra_keep;
> +		__entry->ra_bmval =3D ra->ra_bmval[0];
> +		__assign_sockaddr(addr, &ra->ra_cb.cb_clp->cl_addr,
> +				  sizeof(struct sockaddr_storage))
> +	),
> +	TP_printk("Client %08x:%08x addr=3D%pISpc ra_keep=3D%d ra_bmval=3D0x%x"=
,
> +		__entry->cl_boot, __entry->cl_id,
> +		__get_sockaddr(addr), __entry->ra_keep, __entry->ra_bmval

This needs a "show_recall_any_bitmap" to convert to human-readable
symbols.


> +	)
> +);
> +
> +TRACE_EVENT(nfsd_cb_recall_any_done,
> +	TP_PROTO(
> +		const struct nfsd4_callback *cb,
> +		const struct rpc_task *task
> +	),
> +	TP_ARGS(cb, task),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__field(int, status)
> +	),
> +	TP_fast_assign(
> +		__entry->status =3D task->tk_status;
> +		__entry->cl_boot =3D cb->cb_clp->cl_clientid.cl_boot;
> +		__entry->cl_id =3D cb->cb_clp->cl_clientid.cl_id;
> +	),
> +	TP_printk("client %08x:%08x status=3D%d",
> +		__entry->cl_boot, __entry->cl_id, __entry->status
> +	)
> +);
> +
> DECLARE_EVENT_CLASS(nfsd_cb_done_class,
> 	TP_PROTO(
> 		const stateid_t *stp,
> --=20
> 2.9.5
>=20

--
Chuck Lever



