Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447165AAEE
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jan 2023 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAASJ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Jan 2023 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAASJz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Jan 2023 13:09:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733D26F6
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 10:09:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 301HSVlX024765;
        Sun, 1 Jan 2023 18:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aeu6u3DEOvjNiG4Zg/LKZYPzTUxhdWG+nxS28/T2bwA=;
 b=OMKN6AFZjkmEIUTT5bS4Wi1/rcfeaZrffvfrIuHKxL4C1+Vg5ctbTwUMaKY30ejBV8Gm
 4KY1sxSlZLqUfy43kiT4ZHIvBMAoS1EwkFa2jwBc9ONGdUTdHJf5Vd6NR/xhrGexnkIu
 mRjBEJ/yiKrKq3p/Ey1iOIdwwDlXqCZhDCt/79Ag1kkiYTygyfbZHxq7+sYe0IP5pDZl
 Xu2eUQfINoCQz9ZPQ8hedVaQTbvMUm0AzDZ5LoWAHN56rH1HSgpqPymjx06JoqNCQvNU
 Cg8V4rZMw+0cukslPw3CLvGsuj484uEnIGKT7pAj+QhWX/hiUW2WZjT9Zw7DIZrXToi3 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0se8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Jan 2023 18:09:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 301D1iBa005869;
        Sun, 1 Jan 2023 18:09:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbra75d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Jan 2023 18:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYMmxjYSF/QIlkvoCQBAVXY4jIYDPh3KaUguzKeRp00iLDHbJ2XZdk2ESR27wvZVDPVMhNpyP7qwjhMZQJQav66YDpAsBCVe/emopIzCBQnDiM8qRu212ae4FzLwCg1Xh+7be0lDkc1R8/Sp1rcLNnDlMwlI3SALh0hxjMDFVgdZ4Bn+eM0/WMK7vcf37480kuWBvPoM8Thk29zeA4z54KeGVmNRhWFL6mV8fCGLw2QFICUda1AAAwutA4Xn3RUwWflY3j0nU6FRiIHJEjiPcLyISxkBLfnKKF9VYYG5V7kErhxvPFmOLTeNus0UPqXAu/0rOGxe24XIZ5d9LoFE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeu6u3DEOvjNiG4Zg/LKZYPzTUxhdWG+nxS28/T2bwA=;
 b=I7nLvaxqEfzN+gNgqcPOJwVNq14QTtKJqh2F01mFRLL6NNsbevDokrfF1ZSkTBjYGkEKrcrOWDa9KMjzZn9vrMz6fDtuBXMAAp4Jxhf+X/nlo4vGKB+i+af53PNAlbLId+s03VDSxGuIpI4EA1AEtcObplxxpP4ekskBk86LssY0m1ZYuQOpx5nyRuQVRAm0iZ4T+/s87yZy3FbHeqe6bFYdpbcm3eItAZdTxQOOcKLo++Y8SK/ICaG9JbJ/hu+Nc/oiNB/tJWN5nOHcKsfhT2t4dDAQxvg7YsFbMfKgwkl6Dx3JgVOsUv2KE0THPhDXS9SJdTcgViY8JVoSvneNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeu6u3DEOvjNiG4Zg/LKZYPzTUxhdWG+nxS28/T2bwA=;
 b=Mbhf47lp/OwRYq8pxT+93jf7fMo6fcBKv31ieMVyHG5gQwP5A+8bVUyJ08hEx+JVcg3nYYueuOQwExAjORCG1v+BLxn62ZB3enSmujS9vO1Q+ZPge7icldH4qdYBVv/oJ78eQNRZR9A01RSP220nTKkz5dHMWz7N3qDL1FJfTjQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4216.namprd10.prod.outlook.com (2603:10b6:610:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sun, 1 Jan
 2023 18:09:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Sun, 1 Jan 2023
 18:09:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ian Kent <raven@themaw.net>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Topic: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Index: AQHZDx3smN/KyreXA0qcwVX6hchw565sLBKAgAARQwCAADW/AIAAF7yAgABTIACAHRwugA==
Date:   Sun, 1 Jan 2023 18:09:24 +0000
Message-ID: <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
 <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
 <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
 <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
 <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
 <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
In-Reply-To: <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4216:EE_
x-ms-office365-filtering-correlation-id: ddb25199-82a9-4433-701b-08daec235054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?ORiOmxD6BEWd7l73eNl5DtLYZdMtTex5JH0GWISA1elPNv7m9YRMMb8Dphbr?=
 =?us-ascii?Q?BivjtQiNV5OK95CvWZajdAwWkfM7OnXfdLhwb4DbpD4ko656OcqC5UW+00/u?=
 =?us-ascii?Q?Ibf1GXRaTKzZQsiauyFpzGUJvRqYdijC2eNTkDHGBW6cEyyl52rUd9ogflcY?=
 =?us-ascii?Q?cqzIXZAO5Qp7T3ww8OTr5C+weY3wCwHt0FzHmDQ3lU6LlRibiuWU6S8e+ugn?=
 =?us-ascii?Q?qnClIz0qD/O9Kd4C3Mszg7RIApydyA3qUMUdspZnLfNnN1XaxA4TL77mftNY?=
 =?us-ascii?Q?fX1z/F0E8VQhmywmKPY4Xv7zGLOuNbVbNFufB090Kc8mSs3ZMTf8tMlrUurK?=
 =?us-ascii?Q?yAa+gouh6lszzyNVAGdyMTl+oiXI9xxzyZwf7NLpIj4eoScVGCwXHpHgF6bt?=
 =?us-ascii?Q?pDgS+P/WgJ6ZRMpCmdHMjISss7fMpqX2hwTlcQIgPi/zJAcKGVnxfATaoJ2G?=
 =?us-ascii?Q?6wL50097qQ7b+/SGMlKDmNWvBL7CR6UHOLSz9/gpMuUvTtrjG/mQJ75Dnh+8?=
 =?us-ascii?Q?DdbX6ovH2wO4qsc3PVUJ68CNyPpd/Dyhj40yMRZK3/jG5mDT1tYKxUyRQpbt?=
 =?us-ascii?Q?iToTJEodgpzjjlKfII/62TVql3ht7fu6PRs/brD5g3sWSKPVFKSPgoT7jOXv?=
 =?us-ascii?Q?cZo1bKqsHe6zpKK9gJ3lKnFJDo1LbOrsrdOYI5T99R8C0kZi47lvblSBtxkH?=
 =?us-ascii?Q?/YjnwXuzH+WbKLWZFG7BWbn7Mm5WM4bD3B42BhO4/245RHB2v6UboxId2BLk?=
 =?us-ascii?Q?BG+0G7doDDOYLilCBDlcepvzXgoJnRbZZR6PKYHUj5fJ9X2tR+wr5+yEb+Gk?=
 =?us-ascii?Q?iV9H828c+p5e6dCNUJE+uEjo+/umj2fFztHSGbWFQOjVv79nakdNxNMddUrQ?=
 =?us-ascii?Q?y7HZd+Txt9/oPtRJwRiiW2M4MW3otwYTu505VCPsZVvXpOR2hq0P8bLIJ4G1?=
 =?us-ascii?Q?CaPAWQ7wR2Gl80otFjrDkD7ZGsqdIA1mBMV0JfsSqOmMonJkFWwnsVL6h+RZ?=
 =?us-ascii?Q?+7I3cxNLvgzCSrGoZXLPpbsO3lfxkbZninAzfyf8EieZ0IyJyGigP3MAkGBd?=
 =?us-ascii?Q?q3gbpHrxDcPj53Lt8pxfIuRzFDx2ZDXYxDuEpdc3fyu5Ato/0T6DV198M5pG?=
 =?us-ascii?Q?ka0AsVQuzZ7nPdCis20LZyAq9hohxYeP1Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(8676002)(4326008)(76116006)(66946007)(91956017)(66556008)(64756008)(66446008)(66476007)(6506007)(6486002)(38070700005)(86362001)(53546011)(478600001)(36756003)(122000001)(110136005)(38100700002)(316002)(2616005)(54906003)(71200400001)(8936002)(83380400001)(41300700001)(5660300002)(33656002)(186003)(26005)(4001150100001)(2906002)(6512007)(22166003)(42413004);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yCJC+hh9fldXCqAqfWiz2DmtPQPMcsrC3AwLVLbpJ1EpeDWRzvwfzyXmA59f?=
 =?us-ascii?Q?iKMQIYc6FuI/Iwt8t7JC/kUfZeax4W2E2jgHUEGNGDnm5I7II1TCir4pIkpi?=
 =?us-ascii?Q?ttokc3/rHL/ox3/3TuIc+WZh32ZK+F5JNnHMEFk6suM7ypwYB2MOdhHDQw4X?=
 =?us-ascii?Q?D00XGN7JN7H6kZnmb1NM9xyPxcBwIO/zOx2Gl83YFVw1XstIckRExYtw4iJy?=
 =?us-ascii?Q?65D6ndqluUbYhBuTbzAjUgT5KP5rWdwB0e4CnqkagIc/Ff7DVv3+bNkwGaaL?=
 =?us-ascii?Q?rVbl4mS1GLIBURczFaNWrpAlN1wVbBhodPvsRlOLLeyM4uoeq6S4AO5uWevh?=
 =?us-ascii?Q?EFC7pPzEEWS/TPT2FGf/TeWxxcMQkgAOICYB8P5rHIfE+fIbtv1Ysr4bKP0D?=
 =?us-ascii?Q?Ksuhlc1SmH+2V9hQ8MSjEMHg4hgUCuBXiCldcTtZNJNelPDzx9yXwbCrsjGC?=
 =?us-ascii?Q?9Kcz1wamDz5xKdo38vZ24pc8z4Yjz+YP+h+4EsQQDa+Tpw4y6xiA/h/jA/n4?=
 =?us-ascii?Q?S/RZ2lP1mX5Ah2Y1jGY81/XxbUv0uBghEuHyPFgZHTwNSDcwSwN5ReJziKUS?=
 =?us-ascii?Q?OZNx8fKZMwjbTgMdcecqjbQZlUhBLNvUKMd1bj70aeVX5DC4Z0B3JoKqIKwk?=
 =?us-ascii?Q?xzhvCM0zCA1ngFguGrGoB9Uz43zWLXc9eE3MuCJo8XmvroLCxyKJIfdGkcF7?=
 =?us-ascii?Q?fV83LHjzF8yuyGbCiRy974RZGkQgSt1J7vwBDb/RXeSYiFjlkM+LIxVKNR1l?=
 =?us-ascii?Q?D247BopQ+5mpmLOuBKesEmlQF7lzFnQruz8rMFl+aBshbGx3AtrwRs0voIk2?=
 =?us-ascii?Q?3KUMoOczEXXlaHROacCTsaS6393bgVhrYKWSrypxOeIrj6uEcasbZqeoCHrO?=
 =?us-ascii?Q?ticYkJW5pdoa08j++zV4t/gGfognUOcTpVQmrsEbY0Q6oMnh+i7UWCXHuNFk?=
 =?us-ascii?Q?IZac5mH4SJxJ5GLLjYyeN0/+DcfFHRBUanPA+VSSuY1ubX6q5oxqvwN2Hi+K?=
 =?us-ascii?Q?XOXehi/LUX4s9zkcGVxbHX2/LkiyGnZSbm9DWxz72xmAIRQ+S0GzbBh01eCI?=
 =?us-ascii?Q?p5Cpyfsvt0yCc+eIse8+Gv7tDsYJuzuq0swHXdd9uON0+2szDG84EafoCGJ5?=
 =?us-ascii?Q?Ar2J6OLYgjO8p/3MmLvpjqrDXFOI2XjOjeEbEPxB1wcld1xKDmgiaRFjsq84?=
 =?us-ascii?Q?TzSfhs9k8/5g9fD2Zj0ez42F9KN3KNw9Ek/eKBhSYlL8unblgA/hA9fGSToe?=
 =?us-ascii?Q?9nTqXdXCr+aJZuSpWah0zsoxn77lXGDwNaZJRa47zxMSdBFk7mFi1oQ1PZvb?=
 =?us-ascii?Q?AxeGvqngTvlmshQWiDVNCi+fDzOcriIl73OBhQ6eUR0HKxXLfKlw1UOIKvXG?=
 =?us-ascii?Q?ZGhNH0nyK0IXUaARPvA+xTF1VONca4BfKCSWtCARO4Yoze7x1K/NNcaTpczl?=
 =?us-ascii?Q?mnE/lFvPMfEGsdrwPmMW584f56MBGzlj5q7c5vdm4u9y4vGrxSVyzGjVA5nN?=
 =?us-ascii?Q?LTKv0aVG7Zg3OfJ4HAiw4+CVIPh/tntAS43xHLT3ClDmg/dG7r+y7+dbDazX?=
 =?us-ascii?Q?/20RDsRkz+aLPB6ME8QAOy17sMBd7hIfOBKNDhVD1whtqDUfOb8nowMSaBc3?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3D929153C531A41A72A16A4415AAB4C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb25199-82a9-4433-701b-08daec235054
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2023 18:09:24.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnKKutsHwhxMKI0VETkDPPmMM+OMkTQQjG7gR+xntbHn7+As/YdjBgXLS0wZIduWkadQvcfZc1b4hGa9rq8LJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-01_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301010167
X-Proofpoint-GUID: tolOlEYk6kdaOmw1LaVxVHFrIpX4Rdcu
X-Proofpoint-ORIG-GUID: tolOlEYk6kdaOmw1LaVxVHFrIpX4Rdcu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 14, 2022, at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
>=20
> On 14/12/22 08:39, Jeff Layton wrote:
>> On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
>>> On 14/12/22 04:02, Jeff Layton wrote:
>>>> On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>>>>>> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>=20
>>>>>> If v4 READDIR operation hits a mountpoint and gets back an error,
>>>>>> then it will include that entry in the reply and set RDATTR_ERROR fo=
r it
>>>>>> to the error.
>>>>>>=20
>>>>>> That's fine for "normal" exported filesystems, but on the v4root, we
>>>>>> need to be more careful to only expose the existence of dentries tha=
t
>>>>>> lead to exports.
>>>>>>=20
>>>>>> If the mountd upcall times out while checking to see whether a
>>>>>> mountpoint on the v4root is exported, then we have no recourse other
>>>>>> than to fail the whole operation.
>>>>> Thank you for chasing this down!
>>>>>=20
>>>>> Failing the whole READDIR when mountd times out might be a bad idea.
>>>>> If the mountd upcall times out every time, the client can't make
>>>>> any progress and will continue to emit the failing READDIR request.
>>>>>=20
>>>>> Would it be better to skip the unresolvable entry instead and let
>>>>> the READDIR succeed without that entry?
>>>>>=20
>>>> Mounting doesn't usually require working READDIR. In that situation, a
>>>> readdir() might hang (until the client kills), but a lookup of other
>>>> dentries that aren't perpetually stalled should be ok in this situatio=
n.
>>>>=20
>>>> If mountd is that hosed then I think it's unlikely that any progress
>>>> will be possible anyway.
>>> The READDIR shouldn't trigger a mount yes, but if it's a valid automoun=
t
>>>=20
>>> point (basically a valid dentry in this case I think) it should be list=
ed.
>>>=20
>>> It certainly shouldn't hold up the READDIR, passing into it is when a
>>>=20
>>> mount should occur.
>>>=20
>>>=20
>>> That's usually the behavior we want for automounts, we don't want mount
>>>=20
>>> storms on directories full of automount points.
>>>=20
>>=20
>> We only want to display it if it's a valid _exported_ mountpoint.
>>=20
>> The idea here is to only reveal the parts of the namespace that are
>> exported in the nfsv4 pseudoroot. The "normal" contents are not shown --
>> only exported mountpoints and ancestor directories of those mountpoints.
>>=20
>> We don't want mountd triggering automounts, in general. If the
>> underlying filesystem was exported, then it should also already be
>> mounted, since nfsd doesn't currently trigger automounts in
>> follow_down().
>=20
> Umm ... must they already be mounted?
>=20
>=20
> Can't it be a valid mount point either not yet mounted or timed out
>=20
> and umounted. In that case shouldn't it be listed, I know that's
>=20
> not the that good an outcome because its stat info will change when
>=20
> it gets walked into but it's usually the only sane choice.
>=20
>=20
>>=20
>> There is also a separate patchset by Richard Weinberger to allow nfsd to
>> trigger automounts if the parent filesystem is exported with -o
>> crossmnt. That should be ok with this patch, since the automount will be
>> triggered before the upcall to mountd. That should ensure that it's
>> already mounted by the time we get to upcalling for its export.
>=20
> Yep, saw that, ;)

I'm not sure if there is consensus on this patch.

It's been pushed to nfsd's for-rc branch for wider testing, but if
there's a strong objection I can pull it out before the next -rc PR.


--
Chuck Lever



