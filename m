Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07C703962
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbjEORmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbjEORl3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 13:41:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E71B090
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 10:38:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn4Dw007034;
        Mon, 15 May 2023 17:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cAqrmYnQEkyArMGBFx/JzUVO9jWboDRE7+n4Q40xWPg=;
 b=ObPkBqQLyxD3k86iyzpevCfvgDVsqKNGEuY7DIrUbe0mn7Th/7H7ggcVayI9TLTgcsgW
 OFBUzIc0phqFjiexewTZd2NmpLm8ua9Vl8QVK1pcTgFix8qeEtZDautB4b6vHFz0xtPH
 bfM3U0SFqUjiRs6br/JLCRAzHSg8Wp507i4CKg8moOxxunM9w36lrcl+mQ9UzVBynkl8
 hofSn7tdhbihpNqdp42Z4zKjszaxgSZJGDXJ9yHX34ck4CKjzxvnsMnugGZuzQrUOsnZ
 u9YBn27wcrvjfJt+2fkPJG8ikknMiqOWeKCv7Nm/sxXGLb7I3o3GQLzUTFYV7ECIw275 vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdgmbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:01:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGvaad023042;
        Mon, 15 May 2023 17:01:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102pd5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ4ZV/wu2zpL58NNuKSJDHXNFI4tyz2+C+lxAeksRszMz8JvsTEOdTSfYfvrQNj+oIarZwzqk0zzd+JanLwHuaqgNZNjMbSxUtZ2sGt8JbdhH53GlGPvYln1Czw1VNk6HAvAcD6/rnpHfOYB/4rbst9rbmdV3LGMvgDZl2qQzextRfz1mcPcmhT9aS3hvK5ckyvhYEvVlfoRke7mxeDg/sJPxoe3u8ZO+8RaLM90QLIfN0QG2gl72sAK7M+HFbDC/wSCrvBtc8KHRHl4VBPXKoSkwLOJgAiRJZaAahUA7AI5cj09mW+1vhhjOlX1VJPMD5Pqi6B1Nb8tQ98ax/Fvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAqrmYnQEkyArMGBFx/JzUVO9jWboDRE7+n4Q40xWPg=;
 b=minRWQtmry8FpOm0yetx+XbGVLHV5vv7yea6HXVa58+ILwi+2TyXfWij6/CLau4CK0t0QXTEV/3f+DiRIf6I+9Apt8lqOgCUBblJK2aZCd8eXmL59IwhxmzpR91ALi2aIoP4tw7YJfmFOgKtr038fq2/4f4GKlJSO7236K8WZUnliPkRjUPaGiWMjTFuFAe2U4np9TsX1PvVTJAWfI9pQi1Kv/XUedCdpJ3Wyv5ou8GNB5G6/QiPtVI17UNaBHHZkeWkc3xPlemEd05YS3c0a5VRtgP4tXUe3R3jRkrDcGDUjHUrz6FW6Reeain4o8S0LaU3gd3b5RGxPbDkHgZUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAqrmYnQEkyArMGBFx/JzUVO9jWboDRE7+n4Q40xWPg=;
 b=v8rY0M1JAoJuBlbCbCpN/9Gc/X7pXJtiA26iR9s41qxv8YYnvFavvhQzdyuOVMYs8iy6LF95Lcow3nioCMD+lp3yCLduGcJF297MJs0qfFGScMuMPK1ytkX9UGRsNUgT8i6jI48ZfEBJFBtnTbai6UQS9rNcwZlKQhsR33DkbDU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:01:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:01:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Sherry Yang <sherry.yang@oracle.com>
CC:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU0hWi9leffEW/mcTC+uI3U69G/7aAgAAykoCAABoxAIAA02kAgABBLwCAADWlAIATBXuAgAAHlgA=
Date:   Mon, 15 May 2023 17:01:30 +0000
Message-ID: <1F1F5B47-1CFB-49F3-A9BB-B5E2F65BB261@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
 <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
 <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
 <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
 <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
 <C4EDE804-24D4-4BCD-B8C5-B29CCFF2F8A9@oracle.com>
In-Reply-To: <C4EDE804-24D4-4BCD-B8C5-B29CCFF2F8A9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5821:EE_
x-ms-office365-filtering-correlation-id: 7e48ed93-4ede-4be1-cf02-08db556607af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FuRCpe0Kdb9F68ll5xPL761F1YXV4k9csdOYkoVMbwgjgH+LIk2wam+0XuHG/4eGyRPY6NyoeaaVH8NFYaWjiTAeumF+P+p5WTVTTFF/VfoG21mWWjngX/jWiLIbSosKure/u0LZvQQCFBjvEqnrfLtKk+9HjQdgnHIIoNd5PrNS7CytiihBbqadELO+RHo1fnKVLNaA5AaSquVaLExKq2KakmW6+csXsOnuIEkFg6x4S/MSneRK7goDPBV+dHkonOIug9u01pz8JkpMEAx27du++eZB3thNisynWC4vG0pD1QESQYktJitsfSYFgvyAghA+74MH5mbq2Dm8629/YAUYQM2vCMCZxeucEj2/OjnGsejdx2mrKvrtCJcGOk/GTFRT1cCPu+/9Eujros+IQndtoakqPOwc2TyL1d/8wVGnJKNPYVE/sNCWg+gAMlQTAm+SIUvEPUBWoEsdRQ/NBnDZhjzDCMXT+E1r1i17Y7btfoCAL258ENrGsgzLaqFAcgrbxfuhNVYCyJF6bh9Y1g7kOwUtHk5aZrkY94WICeMBaFlltShcjACBTnxiWCGs8G9t5KBsVZtWgvEJYmyAxgw2Mv/qMdaOAnyo8/Uh8V1abuHZCaNSPY3ujmSxJEImIG6R9INmBiRiMZObrU9yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(966005)(186003)(2616005)(38100700002)(41300700001)(6486002)(107886003)(53546011)(71200400001)(83380400001)(6512007)(6506007)(26005)(478600001)(37006003)(54906003)(91956017)(6636002)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(122000001)(316002)(5660300002)(6862004)(8676002)(8936002)(86362001)(33656002)(2906002)(38070700005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcEjDwpVDOBAxyYgF9Bf2wtE+J7LiCFjCH6ogAE22Iq/MkJLDke+0Z969aca?=
 =?us-ascii?Q?IcFOl5wJuh2SDxbxPamMQaFPajJhriMvo5nNP2OJlWNPd2LBX+4krSFI7BOK?=
 =?us-ascii?Q?CYeG1yfdetXS/3Pe/CgPhDipCmGN8BZv6Vleo4zzX3ySEzjHXU9jfwf3/qp5?=
 =?us-ascii?Q?FvSlQlXSSTotVFZsdij8+mPAY8pY7zoj4CVo932Ice4zBtoo3JrZhV1W8QVA?=
 =?us-ascii?Q?7lOHsnSwwJChkHrfy3i0vYHgjgjaUOa8VUZWpuZ8tsrypHUqKfVF+ayh5TsQ?=
 =?us-ascii?Q?x83tzgm83VIu3m5MkTyOOEP0WI/NTmpe9+Mc3HP6vuoilKESHY1VzOblkRxx?=
 =?us-ascii?Q?nxR201SOcayPA74Gfj3Fq0uA542WzZsPzp9h9wHz+UYFa0RNr5blAZ01fdrN?=
 =?us-ascii?Q?EAZs2tQkRSyyU9wRHfxtQoP7ZciIkJbICgE3Gpq/mV/lQI8mTk0UJZfje24R?=
 =?us-ascii?Q?eVtrdPkh7HvWofsQspF+LCCQQR6MIRrSqtIIQ9zm0/1npbPAIiQStWavW/rL?=
 =?us-ascii?Q?/bkr6DkIUcYsWNUUZuUJLylydAQedzjQGXtcWM+tx7RQwRg8tFTiyBqfa5Vh?=
 =?us-ascii?Q?POz/BH8JEq9sJ3D+wK5Kbgai3YeOpZLKJhgqSpygr2z86ytYTJLG+pVtdmrq?=
 =?us-ascii?Q?LhNa9x9RlbPo+nCldXfw9jeQxgpWoCbEFHTx7Tl1528FFvVNAHwrOmm+lENh?=
 =?us-ascii?Q?iNIplaKG3W2+H8f0Ydro1k75Y/QwR5zEJn6PebNXP0AssKB4R7bejGiGvuhj?=
 =?us-ascii?Q?KTOfYNCvhMmcmIYl1BpcqnMut02oz2lZK1+nJ2ekFSSjRmu0IrUFrpD7q3s4?=
 =?us-ascii?Q?JrAcXQMBrw3ckNFDOvu+wjQKQXQBjXcwEXFyz1x3OskWuWfIYYX0Qp2voiMv?=
 =?us-ascii?Q?OYjhtWRuJTeOLl7PgscTB11lG9t+wh57ZeRtvT0BbIqPsRDfDbMXP5N+0BS0?=
 =?us-ascii?Q?aDVPSciWoTT0d0cqU97/Yd6Y+EM8D0Zj0hvq1vU/2y7IGjrTdLmVBoWtW3ib?=
 =?us-ascii?Q?hTZ3SC4DHIHbg2ht0cfh036g464Iw03kNVxU6Heb/ywMvZFcOYNzrZmnylRz?=
 =?us-ascii?Q?zhdGJ2OQLyIDsID6yNwmV/qvh9ll3l0LmTv5SUqob92ijseZHtVb1Rbez64L?=
 =?us-ascii?Q?pXwRIU/m3/MKAiLJ90BchpsZT0Ibpi9iK03yxSYA8URczraKE+GGSHAKIUtQ?=
 =?us-ascii?Q?H7u2WZIPWXeaL3B7M/ByKQuMdo9dURZ6kMnpDagA51EvDvI+QhTmMVPiJ7I5?=
 =?us-ascii?Q?DyY0I4WSyZcxbr8s/V8UlC4kDc40xK0nHWmoiegclVd4VGIQcrzMdn2ORkR/?=
 =?us-ascii?Q?2Iz0qfv4y/V3IMZ9VJ8C/RQon/b4khjez9X2hOSiRa+mC9hByrLuE850jjGR?=
 =?us-ascii?Q?41ZGQoM9Dfia4FuxrVbww9Fk1yaCfs7P5w/a/C4Py2Ry3IxQ+8e53KpRFQZ+?=
 =?us-ascii?Q?A3/j3Y/xOw478NGaazy4Ybdf2LOEh8d0FFWO6Zfjat5zxoeJN7Fbow+VB2oj?=
 =?us-ascii?Q?Qixh6QAKyraDHenjgNmHCrTJ0smf6z+E5D7DeC5GNnTkVWH30aXwcpxcxptS?=
 =?us-ascii?Q?hoQZMyOVs2fyI83Gk+Fo7YeUyf0/ZiqR8rNiSVJBIUhAMc5zLg7Tj80Tva5H?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7195C2475D459140A5571163CAE8CA88@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SjkUt4cQE64eRQHHt8Fa95W1zd5LTgAEL9015qAWXcplx2L2ZB8W3wGTicxDn/cp1WDZXbYtIvl5XoVkcQlmLEuo7WN6F0dfs8jZuFPl+cvzjlEXlEX+safoaIa8iD+v68ilbe/gNp8C71IvmzimR6wkMdHcoh7+vXDrVGF3pbRDFb08OVPBLXI+vjb/KvM78kBrPmb928zJCOdg4hd+/F2uqnBAcjBOHdiSAEEPSocvCp54rnwVo5uQhMqhj26BTFBZQDEXu2lNPwfj2BuLk/M6d7PVdcIYqGlg/iXe1ws++zKYmkMsivLrsEFfs9U9QO2U2a/gl9S9Jm2vuwHQceI3/wqdplPEXDL6A7GZV2zl/8BoCRbCFAU6zKFxkG5/F/QOrfRP/9pLFT3FFXC/KPoSYNGqVJzqnoDakt7N3coUl70GAMhavRjQbWJH5fxecxxXMNF61ck+NxetewEPSR0PqWESL9auTV9z8SzHOVcpRuqPhXeTwV+oOetheWVbJGEo2iVkh+JvX7+G3LjrX0fzVF26MuRxiG/oFyTyyPZGzeOhWqsF5Vsk2E0toVvgWegzMRLlDj6Ct/R2qiIpBo5gBdXpmuPnuxIcCX40sLCehVA1TpuE0IGzCcF6CQWNdaQAcN2jInyt8x5tguMAw9iQ0ZJw9IKsXmhXTQW9T5R/LWgxYUnNNY6SgUd13fYNbaJYutZDNK88w3Z3jXRQkOsSuR+AjcK8kPhvz9iQapuEiDr0ulv/IJcppCMjPmOsfkfM/vhyFrfPpq4ZrOE5R6/kIh0tJXxvy/chWWTuMoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e48ed93-4ede-4be1-cf02-08db556607af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 17:01:30.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lse6YQx5Qq8HwLbiHG9lLHk+hRoTMjHzRteAZcFFk83iWc+Y3HgNVWKhUXSBDvOnIeKWjZLRSl/D54bJ9dJLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150142
X-Proofpoint-GUID: 7MjXhE3N81rXlN6kZGm8jpgw-OmjK3XA
X-Proofpoint-ORIG-GUID: 7MjXhE3N81rXlN6kZGm8jpgw-OmjK3XA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 15, 2023, at 12:34 PM, Sherry Yang <sherry.yang@oracle.com> wrote:
>=20
>=20
>=20
>> On May 3, 2023, at 7:05 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>=20
>>=20
>>=20
>>> On May 3, 2023, at 6:53 AM, Harshit Mogalapalli <harshit.m.mogalapalli@=
oracle.com> wrote:
>>>=20
>>> Hi Christian,
>>>=20
>>> On 03/05/23 12:30 pm, Christian Brauner wrote:
>>>> On Tue, May 02, 2023 at 06:23:51PM +0000, Chuck Lever III wrote:
>>>>>=20
>>>>>=20
>>>>>> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org>=
 wrote:
>>>>>>>>=20
>>>>>>>> We've aligned setgid behavior over multiple kernel releases. The d=
etails
>>>>>>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.=
2' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>>>>>>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>>>>>>>> Consistent setgid stripping behavior is now encapsulated in the
>>>>>>>> setattr_should_drop_sgid() helper which is used by all filesystems=
 that
>>>>>>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>>>>>>>> raised in e.g., chown_common() and is subject to the
>>>>>>>> setattr_should_drop_sgid() check to determine whether the setgid b=
it can
>>>>>>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally =
it
>>>>>>>> will cause notify_change() to strip it even if the caller had the
>>>>>>>> necessary privileges to retain it. Ensure that nfsd only raises
>>>>>>>> ATR_KILL_SGID if the caller lacks the necessary privileges to reta=
in the
>>>>>>>> setgid bit.
>>>>>>>>=20
>>>>>>>> Without this patch the setgid stripping tests in LTP will fail:
>>>>>>>>=20
>>>>>>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>>>>>>>> non-group-executable file while chown was invoked by super-user, =
while
>>>>>>>>=20
>>>>>>>> [...]
>>>>>>>>=20
>>>>>>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, =
expected 0102700
>>>>>>>>=20
>>>>>>>> [...]
>>>>>>>>=20
>>>>>>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, e=
xpected 0102700
>>>>>>>>=20
>>>>>>>> With this patch all tests pass.
>>>>>>>>=20
>>>>>>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>>>>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>>>>=20
>>>=20
>>> We had a very similar report from kernel-test-robot.
>>>=20
>>> https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
>>>=20
>>> Which points to commit: ed5a7047d201 ("attr: use consistent sgid stripp=
ing checks")
>>>=20
>>> And the above commit is backported to LTS kernels -- 5.10.y,5.15.y and =
6.1.y
>>>=20
>>> So would it be better to tag it to stable by adding "Cc: <stable@vger.k=
ernel.org>" ?
>>>=20
>>> Thanks,
>>> Harshit
>>>=20
>>>>>>> There are some similar fstests failures this fix might address.
>>>>>>>=20
>>>>>>> I've applied this patch to the nfsd-fixes tree for broader
>>>>>>> testing.
>>>>>>=20
>>>>>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefin=
ed!
>>>>>>=20
>>>>>> Did I apply this patch to the wrong kernel?
>>>>>=20
>>>>> setattr_should_drop_sgid() is not available to callers built as
>>>>> modules. It needs an EXPORT_SYMBOL or _GPL.
>>>> Hey Chuck,
>>>> Thanks for taking a look!
>>>> The required export is part of
>>>> commit 4f704d9a835 ("nfs: use vfs setgid helper")
>>>> which is in current mainline as of Monday this week which was part of =
my
>>>> v6.4/vfs.misc PR that was merged.
>>>> So this should all work fine on mainline. Seems I didn't use --base
>>>> which is why that info was missing.
>>>> Thanks!
>>>> Christian
>>=20
>> I'll apply this to nfsd-next (6.5) and add Jeff's Reviewed-by
>> and a Cc: stable.
>=20
> Hi Chuck,
>=20
> Just following up to see if you know when this patch will go to linux mai=
nline and linux-stable?

Howdy- mentioned above: applied to nfsd-next for the v6.5 merge
window, which will open in several weeks.

I added a Cc: stable, so once it is in 6.5-rc it will be automatically
backported into the stable kernels.


--
Chuck Lever


