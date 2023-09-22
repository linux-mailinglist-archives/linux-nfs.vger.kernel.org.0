Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986537ABAA4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIVUtq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjIVUtq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 16:49:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D61B3;
        Fri, 22 Sep 2023 13:49:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MIhVeU019203;
        Fri, 22 Sep 2023 20:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iwS3Egb/qRoBpgrBoHczevKVrPM5cX0J8PuMeDotzPQ=;
 b=zqo9i3Rx4GfMPfAwV2YFQ0VQjNwrd1qqPFYjovaniclJfPnRfWJnLyZ9rQdJnKYzokmV
 6t6rRYD/8p1ZNyBDqnSoaXdhzU8BoTo/HaM+Yx5kbxdHOirbTz++Muo+/Ktxv8j0tuD9
 ev5k5yPqDr98Uf4CBgEyx2zePaFxcsDzijszW2wGS2f075DZfglCyd/KhUOyzCGUr/w/
 iUywC1evXqX5qrHgFKsLJIC22BoHyk4/tgWR/9NrvICIDBEOS5ne0hsvBsy23Vwn1o/E
 AocFibrDWfskZHG56iyBtpI+8Egh7nFs5f1RSkC6dmaOjmt3O6f5gscyQrd8E0bmnblv KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt02wa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 20:49:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MJ4hfi016709;
        Fri, 22 Sep 2023 20:49:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0vmfab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 20:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csz2wiTe0Csy+IAFmAD44Q4RNxe+fRu4OtCQHZwN08+oeWEqmuHMRNTnSZi2A1FgMFRXgybDIfAKLaeWC/EqB/HYvm6meTVqoq6uSi8d/pOXMpKPjqKoeWy9vl1AT19imjT7g3EjeTJg7R4LH5jYUzLtw4c9t4fll/b7o2Na6cYh+eVVQFn6jB+xrCL0USxasanH5jkfhY7KJVRSIDpviW++TTfrvHlhOmdczuULI+Q6L2LfuLRrAzGz2IXxBf2xWpmI/jF8EUbEUZzl7QDcsqK/FOEgzAzzlHhvCqgyaw3mrw9YBk70Lt6T2YyMEDy6qzjM89HTSATlRmQ2nNVPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwS3Egb/qRoBpgrBoHczevKVrPM5cX0J8PuMeDotzPQ=;
 b=KWpV9mU/NsctpsgRbwiqVLrtaiqNEPqoYMzWYFXnzFiToQkJjTHKuUIUXbjiIKsM1g4ryi4HUmCP19MCn2R5jqj/t9oK4O5lR+qxXpHP8gKCxE6d84Nnunb6Tsls63lsXr930zbbX957L/mf9sbDOCafZdZET01NEgoDDZVknwQtSg/uJQVdgh2iyV6G2Acr/Mw0esh0r+F6LIpHILliZNUmwtwOSsw8xXa83XRS8oVC2XzpDmid+XayIILdCy6w3GQjYckDw3f1oa8BL1gwLKO6Mf4xzpBD6bogHL9hSqJb+WJ4Fl5z0N/23T+ooEbBGVbFDJ9QpEa01BtZCJwNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwS3Egb/qRoBpgrBoHczevKVrPM5cX0J8PuMeDotzPQ=;
 b=M/KcYD2JahATsjXHbEU2Hge8JoBaeiGVn3gaNlpL/mSVUkqRicxRUG6yq1F+hyZOP/MGEfDcIOq49qLoaRyXTk3BLb+NknPEpmrDTmM68BmYcLJYNjrjX1e5dUq4rOScsg1zj5QhICuxMFs7jOL6hUQMAvbwjygkkHSnKPNQF4w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 20:49:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 20:49:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Topic: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Index: AQHZ7VKfQ7YihRKqAEKLYXScgapUUbAnAk0AgAAEfQCAABH9gIAAIaGAgAAXdIA=
Date:   Fri, 22 Sep 2023 20:49:27 +0000
Message-ID: <83729996-5666-4F40-9FB3-9719FE11419B@oracle.com>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ZQ2+1NhagxR5bZF+@lore-desk>
 <C6FD2BD6-442D-4F96-82E7-D0F99F700E03@oracle.com>
 <ZQ3qIR036VrSTmAA@lore-desk>
In-Reply-To: <ZQ3qIR036VrSTmAA@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6379:EE_
x-ms-office365-filtering-correlation-id: 10df87a7-7fe4-4c45-ab41-08dbbbad699d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqcWAVrlkxMpbOOFkrgqoLaEBfSgWGW22fTz1yA//rKTc+ZOl7sbGDwLZrxGklDQ+lgrsS/r6+mQE/UljEByTzg2bSixPFy7KZsnFo9uzsX+z8Lm1j2PWqVxIdcHWReEs+G0vbLXCbJCR8QQJMvmBA2J3R4CWULGJ7cJyQEFmdsfbA2m/6iMzxgjROFNrtHjAI2e371pwKAU7QEL8/XNax9LS1Z9F5eoVBkVN4tXdAwKivHdXHV1zZa527God8HjTQXg5tzcuLuU3+6IiOwulJZ4fJzF3fCG/Hr0PlJHk+7VtGsqZaEL43AWyJvLEZFa//oD3f7LveSfegyBQ75YVz+sxKQ2nN7aFNUe5xh3GHlSKoH8gpqQ1Nhav9M0NyC74KEM7I0HyGpTmS91nFs5gH/aoxeaj8xQvcc/KZxQOYFcVGGOY3m60iIzvEYG0xERg9cJgRdRUs5z1jphiORq1UX4dyuGwAC1R7aF9pxhS4FNTdxOwjr0x+Caj3dh7BNn7haTfLWEdLRGyoqQis99HDAF8HzG14CrI0kxi+a072mUVUphJb06J5XRKBnHvkkmQxOgjXH9nZqBHJCOHG5w2F1h/Yz4pbqB0RAcuc80rimwUEU5ryCxlz7+Ocx6AzWk5CBbPcFTDYTnXoWewvCbHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199024)(186009)(1800799009)(2906002)(33656002)(83380400001)(4326008)(8936002)(8676002)(5660300002)(86362001)(26005)(316002)(66946007)(122000001)(38100700002)(6916009)(38070700005)(91956017)(6512007)(966005)(478600001)(2616005)(53546011)(6506007)(6486002)(66446008)(64756008)(66476007)(66556008)(54906003)(76116006)(71200400001)(41300700001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WkXjsGhq1ykk2xn43mRcS7j6N2QCq5tgPEdwjLqEjxBwQU9HMyON53Jt81QY?=
 =?us-ascii?Q?wKkC1Xrn5OM1fruXkq8ESZlXOwuQX9Xcze1GtGeDmbFPhFTnN47T126zwK8g?=
 =?us-ascii?Q?Bf6/X4FD/DpUCKRgqoJ4xpoh1jHyRJyVYbjv5cfCAPMiOhpgS7If9K8NI0ek?=
 =?us-ascii?Q?v4EByp4/M9hBn0WYXaRoQUAdDWFW6NFywK6q7wyqdj3G0b40vsqP7fn3xCdP?=
 =?us-ascii?Q?kiBr3cG3npbY/IqhRmntqxsyBI0BzPcyRpQ28R3POuqBxUhBmZody+mIG4ug?=
 =?us-ascii?Q?c6yzvdgdLhBEHtUE8GCWIi+1J3I6ETPgQLRlvBi0brl3Av/66Hy2Uay/Oltb?=
 =?us-ascii?Q?7oWJPcsx+/DqwzPZWTFzbNc13I2yufzuPfsMOH8l/eVlB5GfdrzOS8fEpVm2?=
 =?us-ascii?Q?kOBe5lQz5jKIWSYxAt72X65sJgmGxIrjSsUSmGib8MAgtaHf0f/eRqJY5e+s?=
 =?us-ascii?Q?OXQN0+VPJXXeKlubjyrd8mxPrnKlHBJ23KAF3zZnAAmuN99JBtYH+1uaLu8+?=
 =?us-ascii?Q?RNO0QyL/VYrzHhaGgrnB/BsUbyLXq0IDYyCLkEt06UJ7DiEW+N7JW5EAmE7u?=
 =?us-ascii?Q?keoJHB8QSOPKMFy+oyNNbOV1MswugAWiJbuH7wye4MO2pP99TOfCBRjrS5T+?=
 =?us-ascii?Q?q2bQxh79SZonJctpaUSz4GuNL+JTnJF6KzTKBVIwX6tQj1Qj1PAgv6wm/XqZ?=
 =?us-ascii?Q?GpArSw/eHMlaqD3CKQk/HtMeN5nh6OYazqb042/725mL+mDjj0VXVJuETK37?=
 =?us-ascii?Q?sWs3GgC73bCgG9MLVwSHBUxxgvORxi2U/EPoWx0aWsCctQ7Le3csRdMJpgew?=
 =?us-ascii?Q?+pxIm1HYSlWVVhep3bec9yJQn/BnWutdLQWSXThaAFbdP9ws8QZ9bfzv2zgP?=
 =?us-ascii?Q?XglG/WMbk9bXdNlA7Nt2t62lzIjydOlAE9J1E08tw4Rs6PnqvaXaHw4Sgd4W?=
 =?us-ascii?Q?gU2kGDsC+to7JLITyjGQu/oKBguqX40tZYzviHLfg6nc7EOg9IK4CN3jUKrr?=
 =?us-ascii?Q?r1uqLoUifcDkgo/HQpptf4o9qfuxfAr8iu+gWqfZauioB/O9h+3BsD3xypRM?=
 =?us-ascii?Q?cZUbBb4LeYaXg37ocx1oCoUMXEkzhj6p8+G+GH/oBura42xJ7+3bJU93aTVm?=
 =?us-ascii?Q?eUv+sRKorrJO/LDt+ISRgN418gtmETdyAQ2w/CvhX+grCJISSbcw+66tZzrN?=
 =?us-ascii?Q?02R6Xr8EQhTziTo1M0/K4GJSfhVF29aNnRqZZ8yu/s8Sg513C1JmrgBftOXZ?=
 =?us-ascii?Q?X9iJWpqxpQrZgRBgQV27EfWLs5qZj0RSasf/0J//gwYLZYhIvfsr9b0x/ZXd?=
 =?us-ascii?Q?7wQLremiV5Z3Aoqx7JkpOPTMnMJYR9sUMM1jiRahy9R29dAa/DfZ2CGsEAVg?=
 =?us-ascii?Q?dDEa/F+Wsn1hA/AnMBLBuq7rHcUH+0+9GyGepL6LNMEkDN+T6QQ33/fDoJVu?=
 =?us-ascii?Q?SKRuUOSEPMPJlaje+jZGnV6P3fpOBqpoS9uuAKCGiVCyUx+XMt9zRsQgwcGA?=
 =?us-ascii?Q?on/4MFhpVpC1z54xC/8cgnK1wgVFl7S4T/44oXpDPrxGydl8r9peppqa7GRS?=
 =?us-ascii?Q?zxXZOVF1mnGpgZSWMXon2woQT7rm3AXxkGFcTpcj5SzqXj7wh1WWeCnD0sIS?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BFFBF191439864783B048E2A33C821F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4czVDe3WR9j1Qpudc4K1dAG9MOri+llIwjFIweQgSYpGu8tMIK01i+7vbOL6ehj9jjCSvhLPrAcvYcpoSarBTk17E1EQtUGBVGKx/QNsgPWp+2izg3i70j67b59VNRIdHk4GuglrUF2colAE9PtgjuGRo8kaUZD+y7zGs+7wuqO4t3VsCTFGELM1EUtIoHt6h9XSS0gk6Ept1MJ26592AJ2x6yv2wv9shz2yBMGCy+/Zn9YwrpCpyr3VEAsh54aHg/aw1VEtw6kuCbtejwI5S0e+aTIoPdubiyKlouyeoXpU6iC+cBCnnKa42wgb1Hv7X6CveHW6/q6HTxPVSCXVgZB2bBsfpC7Ksm7rmBMc9fy3nIo+ciVDcdYw9sf8vSOMrweZMhjXhTeumm+/3p7OwcO3XFVszr6hjPY69bArjtG23Th3i+AJ//egudy1OOH5U9E5v7PsKlr03NdaKhVh+/9P3MLxlfLSItZhX5BM1/SSwe26WZ/lgyHEuU5lr6ztTRuxF44epkpNm/dzijTAgZmPIms01B6teX5dxPBxl/2HhN6XKJILeZu8BKHbdR1D25p4yj2GxzTfkJpfLXceWKYmkn+lPzsOnaTZjigd3nNL7OnMMIrfMZriGRliV37yjZ7t09h8sPRevAWLppQeJ6idO03zLK+ybWbXpAhjrHaq7hbwuc8VRvveidUE6nwpCcIXPH3ZqyZTz3UcuXADhUWROWUh91hwWJAW9HETrT8JAAIJ17mikUP1I/zs7gdDlhmrxXc6mU1KO5iOq+Pqdfma+qXqlLehNNlmE6tdKnRT5fccHtWHc1dI09k1m7VMbG23cEoJ3ckdxiAdi4jKAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df87a7-7fe4-4c45-ab41-08dbbbad699d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 20:49:27.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Fhe5gYiAwg6V730QJvvNxiYcrkGj7R5ZsqaxT46Pt293AA0GzMNOr0onu6V6nsZK7YWKmR092mCPAkGsesjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220178
X-Proofpoint-GUID: wx-M6FPvqj9kXNp1rbZfOcBeJuPjN2A6
X-Proofpoint-ORIG-GUID: wx-M6FPvqj9kXNp1rbZfOcBeJuPjN2A6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2023, at 3:25 PM, Lorenzo Bianconi <lorenzo.bianconi@redhat.co=
m> wrote:
>=20
>>=20
>>=20
>>> On Sep 22, 2023, at 12:20 PM, Lorenzo Bianconi <lorenzo.bianconi@redhat=
.com> wrote:
>>>=20
>>>> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
>>>>> Introduce write_threads and write_v4_end_grace netlink commands simil=
ar
>>>>> to the ones available through the procfs.
>>>>> Introduce nfsd_nl_server_status_get_dumpit netlink command in order t=
o
>>>>> report global server metadata.
>>>>>=20
>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>>>> ---
>>>>> This patch can be tested with user-space tool reported below:
>>>>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>>>>> ---
>>>>> Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
>>>>> fs/nfsd/netlink.c                     | 30 ++++++++
>>>>> fs/nfsd/netlink.h                     |  5 ++
>>>>> fs/nfsd/nfsctl.c                      | 98 ++++++++++++++++++++++++++=
+
>>>>> include/uapi/linux/nfsd_netlink.h     | 11 +++
>>>>> 5 files changed, 177 insertions(+)
>>>>>=20
>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
>>>>> index 403d3e3a04f3..fa1204892703 100644
>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>> @@ -62,6 +62,15 @@ attribute-sets:
>>>>>        name: compound-ops
>>>>>        type: u32
>>>>>        multi-attr: true
>>>>> +  -
>>>>> +    name: server-attr
>>>>> +    attributes:
>>>>> +      -
>>>>> +        name: threads
>>>>> +        type: u16
>>>>=20
>>>> 65k threads ought to be enough for anybody!
>>>=20
>>> maybe u8 is fine here :)
>>=20
>> 32-bit is the usual for this kind of interface. I don't think we need to=
 go with 16-bit.
>=20
> ack, fine
>=20
>>=20
>>=20
>>>>> +      -
>>>>> +        name: v4-grace
>>>>> +        type: u8
>>>>>=20
>>>>> operations:
>>>>>  list:
>>>>> @@ -72,3 +81,27 @@ operations:
>>>>>      dump:
>>>>>        pre: nfsd-nl-rpc-status-get-start
>>>>>        post: nfsd-nl-rpc-status-get-done
>>>>> +    -
>>>>> +      name: threads-set
>>>>> +      doc: set the number of running threads
>>>>> +      attribute-set: server-attr
>>>>> +      flags: [ admin-perm ]
>=20
> [...]
>=20
>>>=20
>>> I am not sure if ynl supports a doit operation with a request with no p=
arameters.
>>> @Chuck, Jakub: any input here?
>>=20
>> I think it does, I might have done something like that for one of the
>> handshake protocol commands.
>=20
> please correct me if I am wrong but in Documentation/netlink/specs/handsh=
ake.yaml
> we have accept and done operations and both of them have some parameters =
in the
> request field, right?

I was probably thinking of a command that did not make it into the
final upstream version of handshake.


>> But I think Jeff's right, end_grace might be better postponed. Pick any =
of
>> the others that you think might be easy to implement instead.
>=20
> ack, fine. Do you agree to have a global container (server-status-get) fo=
r all
> the server metadata instead of adding dedicated get APIs?

At this point I would like to have a distinct command for each data
item.


> Regards,
> Lorenzo
>=20
>>=20
>>=20
>>> Regards,
>>> Lorenzo
>>>=20
>>>>=20
>>>>> + return 0;
>>>>> +#else
>>>>> + return -EOPNOTSUPP;
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpi=
t
>>>>> + * @cb: netlink metadata and command arguments
>>>>> + *
>>>>> + * Return values:
>>>>> + *   %0: The server_status_get command may proceed
>>>>> + *   %-ENODEV: There is no NFSD running in this namespace
>>>>> + */
>>>>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
>>>>> +{
>>>>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
>>>>> +
>>>>> + return nn->nfsd_serv ? 0 : -ENODEV;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * nfsd_nl_server_status_get_dumpit - dump server status info
>>>>> + * @skb: reply buffer
>>>>> + * @cb: netlink metadata and command arguments
>>>>> + *
>>>>> + * Returns the size of the reply or a negative errno.
>>>>> + */
>>>>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>>>>> +     struct netlink_callback *cb)
>>>>> +{
>>>>> + struct net *net =3D sock_net(skb->sk);
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> + void *hdr;
>>>>> +
>>>>> + if (cb->args[0]) /* already consumed */
>>>>> + return 0;
>>>>> +
>>>>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
>>>>> +  &nfsd_nl_family, NLM_F_MULTI,
>>>>> +  NFSD_CMD_SERVER_STATUS_GET);
>>>>> + if (!hdr)
>>>>> + return -ENOBUFS;
>>>>> +
>>>>> + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net=
)))
>>>>> + return -ENOBUFS;
>>>>> +#ifdef CONFIG_NFSD_V4
>>>>> + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
>>>>> + return -ENOBUFS;
>>>>> +#endif /* CONFIG_NFSD_V4 */
>>>>> +
>>>>> + genlmsg_end(skb, hdr);
>>>>> + cb->args[0] =3D 1;
>>>>> +
>>>>> + return skb->len;
>>>>> +}
>>>>> +
>>>>> /**
>>>>> * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>>>> * @net: a freshly-created network namespace
>>>>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
>>>>> index c8ae72466ee6..b82fbc53d336 100644
>>>>> --- a/include/uapi/linux/nfsd_netlink.h
>>>>> +++ b/include/uapi/linux/nfsd_netlink.h
>>>>> @@ -29,8 +29,19 @@ enum {
>>>>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>>>>> };
>>>>>=20
>>>>> +enum {
>>>>> + NFSD_A_SERVER_ATTR_THREADS =3D 1,
>>>>> + NFSD_A_SERVER_ATTR_V4_GRACE,
>>>>> +
>>>>> + __NFSD_A_SERVER_ATTR_MAX,
>>>>> + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
>>>>> +};
>>>>> +
>>>>> enum {
>>>>> NFSD_CMD_RPC_STATUS_GET =3D 1,
>>>>> + NFSD_CMD_THREADS_SET,
>>>>> + NFSD_CMD_V4_GRACE_RELEASE,
>>>>> + NFSD_CMD_SERVER_STATUS_GET,
>>>>>=20
>>>>> __NFSD_CMD_MAX,
>>>>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>>>>=20
>>>> --=20
>>>> Jeff Layton <jlayton@kernel.org>
>>>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


