Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00A697E59
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBOOaz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 09:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOOav (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 09:30:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026FA3431D;
        Wed, 15 Feb 2023 06:30:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FDTCo0032553;
        Wed, 15 Feb 2023 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7OtgkppD0YKGxz/HSUAKPPwHHaiss9nHE0LlN+8DLyo=;
 b=JrSTf7XMtXt8yg2dzzt/7+GiCT0RJeGUivEsta2OXwJ5p3X4Br54VrsPoL4Bd7dnZq4A
 /GEQTMVSKBnmRNNn/ErxPzWZ1d+LmRhfrv3H3Pq3E52sVuBc/SYA5PiRD/KheocxYSOc
 rOJ6c+r1t7lxbiVVf/yLlpr6uh+Y2sHBPmS6kjYyIFLIbV7lUZ0NcPiins+KYKTB9vro
 ptExnI2/6Z6Nj27jez0QON7cAK+t7LfFlSx0TqIgPCoNNh4+dpen3k3gap4KB7NxX/Hw
 EvK+xXIpdIm3AI+NJ441EtdBQtTQzJbjbsW2KY1lNHzOrEj8p4BD2bB+brGWG1LqUVHM aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m10fqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 14:30:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FCmQmR016790;
        Wed, 15 Feb 2023 14:30:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f774rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+YVQRzki/jg2EcR3C3Pebf9+TqQ8ZlKa2v4L7uNp4px0S8zySUa5ofLBB3iSAE9U9Lu7q/w7Sg1auaPXtsR1KI0ywLnKPyYHPeMeOWcOY/QQOUQp3LMXnaYmu9nD3e+avI/sEYnccmX2teW34ixJgdT3q9bZgAGwgodnQ6MJoPLvW6awzZM/yjZYApJjRVavbn+89R5GyjkwjZEl8qREEJ8LwFNUnEG5SC4XKCmQGa08f70Ublz8bRv3VToKwLKbVS1pMnPEJQgGhuZE8kGPUdKij88QQkemLzEDEiXU6z2K70H4tuYQ6XOAyUf9Duws9K8dmFeXUUCsUcbB+wBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OtgkppD0YKGxz/HSUAKPPwHHaiss9nHE0LlN+8DLyo=;
 b=bcrheWrV43BB+nVp9EMiI9/fwMkMX/+f2RGgEggyw6BZXdEWUJyORXewESXuC+tK6JO+GsXRwQ9nENXNG3GC/xs9ykwbBtPuZT79ussyb9oggPN7lpkia42yVUyTvxeLuP5wlgX5mtDb8GscoAqNGws3Ooda04xrhSHHY8uudS0HPbYk1JdCKXStj9rENiEYobBbQFuh5e6fgK3j+b/ggt5YzF9D/OS5dqltTq0nqW1x5AZ8yC671r2LG/aYarAASnem+Rw+wPy3Wb2mpFkGEsJjKpdkiiAhmoQDLsfQ7735YcBLivl3ewpYLbkRK5RebkhVLP/xHReNAHvBO21IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OtgkppD0YKGxz/HSUAKPPwHHaiss9nHE0LlN+8DLyo=;
 b=CqmkMILcRjf/dw21pVcW13KryUZU2M4/DWcQon4ezOyBsuC2RM7BF8mrPsL39hweS2ue6QKRbcBfZUiWvYi82vg2432Ohc53VelUbZilKfj0hQs8Wq6E5e7NNQQTAqlWjYs345yBOz8oLqICbjnRRpW54f+GUZ1bEDU5RYZdNZ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 14:30:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 14:30:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] fifth v6.2-rc request for nfsd
Thread-Topic: [GIT PULL] fifth v6.2-rc request for nfsd
Thread-Index: AQHZQUoUCMPozJqltUKaVy7eGiGe9Q==
Date:   Wed, 15 Feb 2023 14:30:40 +0000
Message-ID: <A1496B44-86CE-4F63-8A84-DF0C04F6A6BC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6845:EE_
x-ms-office365-filtering-correlation-id: 6dee41e7-fee1-491b-f649-08db0f6136c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJx2nT3wm/8BXHlhvg87TXuvE82o6A4S2IhHqU23ZPDq0BiCeV+54hANdwnHKeb9E7ciF7GBvpT/q+w2rIMxRmRBBvY+Ipx4v+0bvzVpbc2aXQbcQx9cKTacgTf22/LKoXYahbJevbmL9UmBshOfDavnFdVkWXHNGS2yJsIZSCR1sAJmsAhRisdv4tHWkpXvC8C3Uag9cWJ9so9Gp8I21vzuMh71eaZ613aSsCX8ismSCBZvTBr+XGgw81KZ/Ji94JPL7jSGFe6D88YTDB9v+Dw23ZEgi4TyXXHtK3f57PagbY9zM4H9c1IqVKJYP+pDOrRm6n6m35Kwp7B1u44Fticf4jfgsvmNARd8eHjKIshLJWIBJ03u1WJWvDkWm6HKt4jdbOCcnkp7/FGGHynLG5I5kZEvtAY30gooGnoHX6RAr3MHZAXzFqYYqYt/QBPJ5VfqyEkluOzGGrOdd40L/erIbgWVTj0Y50+mjwVCw3f2E3FVV3Ch3a8gNVMn1sgBE1ZvrHx+IU0CeVH5JBNpvmZojnaMo9cdgDQIgAGsKev+Lbvx5ERF3SHoFopHAGa6rI2lgK3oxk7l1mY++qD7qWMU9QbjSwyjsihDSal8m//Zb3DHSuQKXKdPTHMlmk30bN1+y7b6dqHohlgOIly5U82SYUkWMYrNpy1+8QyQp5giLCZ/iGajHmdh5F44bQMPLrQXfgHEnVNRFVjoZxXvsH6jAnUd96So8nRvFAUqm/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(2616005)(966005)(83380400001)(6486002)(478600001)(6512007)(26005)(186003)(33656002)(6506007)(36756003)(38070700005)(86362001)(71200400001)(38100700002)(122000001)(8936002)(4744005)(5660300002)(54906003)(66556008)(4326008)(8676002)(6916009)(76116006)(91956017)(66946007)(66476007)(316002)(41300700001)(66446008)(64756008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtUqi2X/koCx+8Z5OpBLzgel59zVIkaxYJqn3sYAAYtIxGAnrhoGlelwGmAT?=
 =?us-ascii?Q?qYgUTp6u+ej3RSEEd/M28Ns8bO/sY1GheD3Nl/zSZDdozz7GhbCFSR+GUMvJ?=
 =?us-ascii?Q?Bq7mg3Tz+RJH2EwVF1s15S/+Ysw29xXlQS7d7D5uS5/tpPaxSn0HbbNgQ8Vm?=
 =?us-ascii?Q?eYb+nonJakPPWXtzFqvlmwjsFfC4s8BdCvMEC+N1j4g7B2SuAXhh4k/Cf7pN?=
 =?us-ascii?Q?40b4oZFbngQG2PWmV5ALPqoG09CyeEsJHFC1VYTa72s8KG0a6Gz72bhheUCD?=
 =?us-ascii?Q?dPrd2JO4A2RMlfqzdSVq6rIlD8bwjKtiv3Ip9CBkqIUhi5NPOBq2rM6m55bV?=
 =?us-ascii?Q?Iip5x+RUrzrs97be9Ul+f3b9DxIPaTRNU9WhWC81qOo6raRDXjV+BqCvRvdH?=
 =?us-ascii?Q?+FaHpBlTE2LziJmYPCBXuXDlJ62A96GkAX1aV2pDr1G5IoL5PNU6M9gZGEIf?=
 =?us-ascii?Q?zTlz7ajlJVudcvTM3UCu4vorRXnnotUBi60MI+4aiHNwe3TgHCJK/YzTC9Fq?=
 =?us-ascii?Q?lQRiRmzxQ6esP6M3bvf+ErsgiCDHMm0a5PXCb9tqPc9SeXO45awuCdWHJbgC?=
 =?us-ascii?Q?6gsx+SeC9ddWrmcGldB9RJtdgWkWaYb0CjDQij89oUpzUa9Z4iB10nWyVNDT?=
 =?us-ascii?Q?a/joHLyC4HAgmU1M0VswN3CUuLhTYOlDA5Fzs8GY6Gof5OKXbNGJx25Lteti?=
 =?us-ascii?Q?ubOFJbMTEg1VlbLvt6uqKYfZzfMjL7CsmbaAWVKiPYEfVuoF8htIB0Yzi9H/?=
 =?us-ascii?Q?8oRutMlgJNYDP9bK4XLaPi4fD+cj8b7WXFbJgBXkIFAaoGNEH0ZN+Y1PaVla?=
 =?us-ascii?Q?+s8BbQWCeCRYjyfbJYZIwXMTqQTvs9Yf9RQhRDrex0UXmZYv3PO7wTRuGEk+?=
 =?us-ascii?Q?ia7SYFrCY8OmKZKUFtf1zfnH0qbqfswTN9a3zlauiWt5Xqu2Iy2lTk0dLT6z?=
 =?us-ascii?Q?u2xNcVgp5jcBGr1Sez+xSFLY/fmkbygAUUn43ANxTuhVIQ1h0IvPnnXff7tZ?=
 =?us-ascii?Q?X4fvfs/ezJYWr0rW8BPWyox9s7zTeySPDWNSueE4ElKrV3MTnBOlH2sDdS/W?=
 =?us-ascii?Q?7oyPBWb3z2fR5dn3XCUVK+JIZSWWdRk5CPxYfBjZIW5Ng03qdDfk+CVbWeAp?=
 =?us-ascii?Q?KpTeEailcSQ3kjjI9KxnQKE+tfIkKWMjv5ocnxsxqet3I0TcWpJPTGPtKnes?=
 =?us-ascii?Q?Izb3q+O4fguFcWIMKRGLjyWL7XlVIO3Y5ZzHlD+k2e7k6Fyrtac/KFC4VUrQ?=
 =?us-ascii?Q?ntHBQn+PYXbt6/wOMGjhjgMC0qjtKYuG8PMeeo/gygfA127f/DqoVPPMc/1a?=
 =?us-ascii?Q?6scQMvoQzwwgx2iyCbnih2U2DxY+t6t7pawwEqP4+Mtjt+4TCOLejBg0LOUx?=
 =?us-ascii?Q?HG/JAYCpKDfKHrwAW5OiB0m5O9J4aaX2I1mD2eQwEDkUSgG0jtMG7rQoJSI7?=
 =?us-ascii?Q?/2WiTLb1w8dXhRXSsq2uu5sCsaULqisiQgKKw1Je1JUHNlKE++LemgnpF22b?=
 =?us-ascii?Q?Q0p2rDyEAvTl7Rp1aoniUHXMvDz4oNpIsWY8pwdXpHP1nu5CSH0PnNu1s8ZN?=
 =?us-ascii?Q?GNEbym17DE596fSLFJ/9iReL0vTCbrvl9H8KiO0R7S6ZRBQN2SYIxiVZWpn0?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9970C245F96FFC4A829AEA0A53362D0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E9fxYMqiXL9ksl4GJot96rforVaUqrNHnVAdNa7C39xeO1RM8wPnxYiVBcwlDdiu6ZVuPH4XyPLC61Va2muHE6zl25t9M+51JYN7Vh++RWV42W5xeFgtn7QpZdh5pBMwKeNwuphbJsXwbp401Gm9pKiOTj05hxp6rVAV26lD/ZNwsucq5fT4u1XMA1TD+ZyqigPxBf2crD5CxQ1caJwJORvEz6sqoTQO2q2M2jVkZpXoyGrBI+fPRxibBRlHtrnqhfSkxQf7fsJb9eIy6PuGo4hx3VpRYbE3f6jGmVORH3/+w/RcfZxFauZc4IcjgPrKMi+/mdi8gPYQY7twsTDJQTUWtkRfq7tdSHGnlCjm8ICHA8Cg74LPmpb/oIj6nn4V8q6+ebLTRrLwjVQUBitQYBgwvSragqUvJ20WEEjCQ8jGHu3u2Rq67cdohcETFSJGXMYv0FxVDsuQxszii7SqusNbgWeXVUSEV0wlbBlgfV5/wCWIPjgdhG1Q4fsWr/OnCLjTKLU5dwpfE45RG7vP4aH80OZPepooF2LXfhsDvBbC6BXaf0CvIgtb4HU1BsCoAsdVNwhfNN4Fq0NSdwDxhXuyLYRnBFdtqf8h5AJT4nkK9f2I5AusHGCoOIwGSI+v3AdL+yyFN8eASzoEHVCnQUfvUxIQdPh2XxV+vAjIQDhdZjthMFvyIwJRHRs8QpWT/9VRnOdk4nNG6IIPjs8zkbbHySzuCohKpQmLR74dIzq+CqbHrBo86Aq0rZ3m2mfylpjpaRXr5kLmLg3bVLl0U9lDAbqM3bbGqyYTiz8Nnr0SWeRFAej+oHQUqIS0t+hO0IVmbc2Wrnel69R3DUf2NhyjdoMCwKnlOXNDBGT3c0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dee41e7-fee1-491b-f649-08db0f6136c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 14:30:40.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfUbJ4MH6G/3OXlS35qNV0J/hiosSZNvu//HkkOnb2QzEjqqlHetIlVqi9i84Y7h89hRPYlT6K19PQqkgijOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=862 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150130
X-Proofpoint-GUID: zGTJtzRPIqhgGja96nIURsuolNLwC5aP
X-Proofpoint-ORIG-GUID: zGTJtzRPIqhgGja96nIURsuolNLwC5aP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 4bdbba54e9b1c769da8ded9abd209d765715e1d6=
:

  nfsd: don't free files unconditionally in __nfsd_file_cache_purge (2023-0=
1-23 09:51:17 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-6

for you to fetch changes up to 4102db175b5d884d133270fdbd0e59111ce688fc:

  nfsd: don't destroy global nfs4_file table in per-net shutdown (2023-02-1=
1 12:09:44 -0500)

----------------------------------------------------------------
nfsd-6.2 fixes:
- Fix a teardown bug in the new nfs4_file hashtable

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: don't destroy global nfs4_file table in per-net shutdown

 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
Chuck Lever



