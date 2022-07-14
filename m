Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207D5753AA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiGNRCp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiGNRCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:02:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F05724C;
        Thu, 14 Jul 2022 10:02:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFvskb000871;
        Thu, 14 Jul 2022 17:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zSlVk9pomjGpA9ESyLpManPJVIUWXZvFlCJfXeX5jyE=;
 b=X8wvhUYU72TciwCgrd9cW6ht74pD099LcM0t0ZNJdS6rF9RfJnlq6DmfD0fhxFY06qJ6
 hlHxqpRUvi+oleV+U2XV+w9LGxMOgLMZr8FfWzcRaXOO2DEe9BEi7CF8SxCEGd0livYK
 dNY3+fOBG90zYLBbp2lWP5Y/UzJNchn4HV4V9fU6RZpjbGW6ldUTYXU5ELaoPh7SNN5A
 6h3oy/eyn4YZVXqI5h+kksuWAastQfR3YgxlFOZoEIbsQHWIeY+L9ag9jR/JDpBfvciP
 oviyZ5mZOtt3jnmnHaTR5jN6YXddjGu0IpnO8Czsher+vykjzc7zftcnP/rE80giTgDP Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrnsr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:02:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EH0IUq027789;
        Thu, 14 Jul 2022 17:02:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046h7mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuIHIC269RasKlSBPe7idjitWklunaGjnMc3N65bqYiXnXJlYEYo+6W9mN0zb5kWDMiTshHgtM/M4RvFJO5rnmLrkreYMU7jW76j6CXyQeA1V3wHYmk9uKwW6ztndt/WrPYLl/FzepIO9FecmBStTuvtJ140ts47pu2iZOE+Dao0L01qsVD1jeEj0dyLEjPIYYqcAY/SyOZfguzQJNhezV+7w+g3dDZ+4wg2lHP2D4vbD1zWfivSXpD+v/GRLo+s+5ujnhZsdc5twfaNdLoa1rkOOOMqkEi6d4d3zJczS+yogHmCzEBZCZhNkhlnZNO8SFkhXuUZAjLgWjS14I0dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlVk9pomjGpA9ESyLpManPJVIUWXZvFlCJfXeX5jyE=;
 b=Ii0jVw4f1r8zc6aR1UKerKEaZK28cjw2QJdoF8rGH6JRU+TM+YFVhZ3ZB0ZC9YIXkOwBEZVTjHC+tTCpDAa6Q46pOHH9LHjv296Q758ArC90tUfyLcDRFknDXUcRKvew6ZHXD0W9Bk0QRJfO9Qhrf43U0KMcLFv2QHkdlUO/7mCDCf1qSY/IuFjbiTq+0iuSuKNUgLv+zAg0ynih+MD2cu4CDEj7sH2eArlvUyVlYpMxQffLifA3zZokIP9J7ZB3vnyQSj3krpp/lyel7SKl9+cjp+YfmKLAb4DcymkWlrs//S/XvZODthBTVgLZyuxn5Ax1PesBongI2fYG03MJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSlVk9pomjGpA9ESyLpManPJVIUWXZvFlCJfXeX5jyE=;
 b=Vs7fPVhmZr0jY7eifjEf9L6oHmuxyRGfrTJewyhexuck8JJa21kEI1ehu/I2+s5MnSb2YkoIK2X9WtZbdqqUY6YjKw3fvTYAGqdKgtjQWV3amRoaeFaynsFYJh0tV7k8Aveuqa1bg2J9DyvpbqzwL+c2UgifGsnaSkw6DA1DiE8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2580.namprd10.prod.outlook.com (2603:10b6:406:c3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:02:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 17:02:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 3rd round of nfsd fixes for 5.19
Thread-Topic: [GIT PULL] 3rd round of nfsd fixes for 5.19
Thread-Index: AQHYl6OE1V3Uq6cMC0eq+JoTgplj2A==
Date:   Thu, 14 Jul 2022 17:02:35 +0000
Message-ID: <5E921C2D-2309-4EEF-B360-A27361CA9F2B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efbb5a95-ba84-4a68-046d-08da65baa69c
x-ms-traffictypediagnostic: BN7PR10MB2580:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGjnMxl9lWbj50BcbboxhZT5PdL8cG39CnPSS1Rs5kjhTF6MnMZ+kd/GwUEKd1m1HlQOt/x7fdwx95+TDVDDDjnCeLVM2aNzz/dconjC+aIhaMwcjehlGNU+iiGA7tryqkOdy/TWtiegK9GAB32GZmQCD81OJRFyQwgUwPgC7Z2xXEyFyCuE/QFPxQoDZdGnMbPZzruygAyWsS0detPqVE6Iphfc7WDXbUm9gHnRO0qkp44kEd4WG3lqA1eOAyI5vCk8CDQxz0Ht1SfFbI6DTaJJqiZlgqPCCuDeVbPpHFrIagNcX/MAJLqqhZ7DCMbeeRoK0HvR3eDuaK8TSe7dIU1D6b/CvixpGZBFsornqwF7rBwiOwDJbc7illBa2311oc/AxrdtLZiltluYtnT2sdCyXpqxER/GAU6D1ktU5V479qJErMO7E7QxtYQUiBeI94uTk1PMvk/vjW2hLZYFlH/M9ddkHgFdkewjIboHgjcp+J0lM7CzVMrGmhYMs2JAW+nCnR4mkZt0SQ1FFfGow7TRiVgJtduCe19gtm6yoCa6G1ILvABIHIIyrglJUU67WxBKfxh5r69ARHIEiMzfhK41dUDpktWw93rsqfandjFsT4u+y1Gdp2fSxUgwx6Xg8grI1W0/GDqpS/irt3DBI/PwQa62Cv5hRIFEwR+DGYwCgQxQm9zbdCeXL7CtedZTtSC4Lu+JR+1NPQgS6zlMtDKQ8NLaW7TjaMOKIa2sCuBcaiOoIoV4QqokyjynerPh//9PQRiRqPriB/fU/IlHX5siPFTZxDecRSrPUcxKl7ZGFM+ST+YeT0/xtFvYRmhvkHYyYazvdklBneGWR8IuHTNbzFoRoriDsuLPdy3C4v8NsgIkYoZRzEUMbZgL2x8Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(396003)(39860400002)(71200400001)(316002)(54906003)(6916009)(186003)(86362001)(83380400001)(2616005)(966005)(41300700001)(478600001)(6486002)(26005)(6512007)(6506007)(2906002)(8936002)(5660300002)(36756003)(38070700005)(122000001)(38100700002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(8676002)(4744005)(91956017)(33656002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?er0fFYNRNA/lw/A3TSHFJ/9HQxW0h+bPOMP6K9b7L4TNchIM04/9YNQpmE4Y?=
 =?us-ascii?Q?CpHj9tPWGtzurUnjiS4BuXZMncJt597WvkfVhrpjGvQFqKB6doBxeD4uC4uf?=
 =?us-ascii?Q?T4DMDLA5z6ERXk+D7jVnb6y/f+Cz3xrsMTeAeZMlLbHJTOOwt2Xv7TdYnkeq?=
 =?us-ascii?Q?ZErbf8hq9UgtnOpdSeLxVHOroTAg2dqNhU8zPDPyruFTa5mBm08HC1GnSy/3?=
 =?us-ascii?Q?KsLLzG/rITPkG8YyZKbiCqHtc7SyMnNQhzoFHIXifPBS1rBflme1pVyeYI/X?=
 =?us-ascii?Q?C9CluQ4P8Alj0aqVnZqetqJkCeYzrS+FszES5KVULFKcg+gWkbhhUogxM+wX?=
 =?us-ascii?Q?+FJnr870fVXQSQK/GY4BlplizML0Sy0/dmILaAg/xKJLWawvAXusMBvbXzgy?=
 =?us-ascii?Q?+9gOJ37WIDzGE+QlTMT0oD/GX/uqa1cYJpMXNqZDLDHtWsZvBk/AzAvZXEeH?=
 =?us-ascii?Q?pTrTf5o0PCbMW0vxAc+DIFzCnELj0N0mfkj6rS+AOf3i8rkK5gN6njxFZ6Sq?=
 =?us-ascii?Q?m7m3KNtG9sR8baUOxhDi7Ml8UdraxeovO51+cETSppuemjORy2uNGIT5t4Ms?=
 =?us-ascii?Q?Uh+KeZFaaIoH5OSQNunRy9o2PZ+2aIW3MsBm1XzWEfRzmg++DTsuIUBbAVcR?=
 =?us-ascii?Q?Gu8S+WOaAbQ/7DVUv9CdNV98tS137LWO0J2S6nql30/L5QI3rjvtWGjgyZY3?=
 =?us-ascii?Q?LfelqbwaCT4UvmEpDwIW0dJNnYM7THEH0m0I1Rob7chnFwGZT3dDI66X/SM7?=
 =?us-ascii?Q?MQ8NDpW4aUjLxALmZOXCU25j/gGDoovtoB0ZaGTvr8i092rwbmhBfpj0ALu/?=
 =?us-ascii?Q?qPAKES9GIaF91mStNImgmXaiyfdO61GbLrN0O5Jie/5Q6fcUSxdRsy9ZD4wm?=
 =?us-ascii?Q?q7UqQfSDrNZXFXh18/48EHpr1ukfAHmBKFbr4evgt+e8HEwdElI0VScymKCH?=
 =?us-ascii?Q?nkCXNrtO9jjeXD8Fg8Us3o/wBKWNY3UoKzTnJJpEh1/SCQRQZBHTu/mbVrk2?=
 =?us-ascii?Q?vErhGKQ62lJSAaGdLnGYR2FIdi6pxjDO/82aF6H1RQfm6oBkbqE4I8z4TvXn?=
 =?us-ascii?Q?3cpLtsZ9JNB4nnRclBt4mkbGE5C12pvtUGh5ydFPXscc03PI9m5THVKHKsh1?=
 =?us-ascii?Q?Q/A0MuRH1j5uBGOTz976SDb+ar8X8uRR+nSk3sf5vz2vWsDgziO3SWejrmTk?=
 =?us-ascii?Q?RkXJ/o97h7yJmfkaWtZwqCJGCrYFJ5lOtXCTBk92AjvbTzK+lrbuxvt34FHa?=
 =?us-ascii?Q?4VhAI7Gkz+xniEhgO+cMfuT2hkyZ9s+HybF6aDeJaD1tXwcL6S95YNaukoI9?=
 =?us-ascii?Q?0TTAQyNXLnszDsM3TpickCIqOJ6lksZKfKwYcsxxIZH1BrL3j2j5jvfLjj9P?=
 =?us-ascii?Q?gGnNntm18TmvT7DKoVXnjXgfsqzvqBNUA+lcH1lxK06eunU+8oi3ruIGbJdI?=
 =?us-ascii?Q?ZFka4mKmzefJXxU/Ds39NwiAWalOyBfxl6UO7npzMLKJrFUv9wlzq0AxoFok?=
 =?us-ascii?Q?6en6u8izpxUsjZRZYNbZyM9BfdWVCv8g5q8Rf8Sbv+I749QQwCO0XuJo4YAu?=
 =?us-ascii?Q?6BlY0gWInLiaQIqWhXRW38H1lpgaDi+/Mu6l1Dl3oZ3viDp+onDwlXm0hCtf?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E163B22762BCA4896E8ADBA2B3B4839@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb5a95-ba84-4a68-046d-08da65baa69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 17:02:35.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5Q28tur4VWATsSiAU0fNdXF0SWsyEchyT/7sA557PU129uHVOrN20oYRt+DwOCNmaOXLEjiaGClm3Uhj6YtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=969
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140074
X-Proofpoint-GUID: MjPp38WPcV7eRoLZcBGB8UvcfMBDmVRj
X-Proofpoint-ORIG-GUID: MjPp38WPcV7eRoLZcBGB8UvcfMBDmVRj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Linus-

The following changes since commit a23dd544debcda4ee4a549ec7de59e85c3c8345c=
:

  SUNRPC: Fix READ_PLUS crasher (2022-06-30 17:41:08 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5=
.19-3

for you to fetch changes up to 1197eb5906a5464dbaea24cac296dfc38499cc00:

  lockd: fix nlm_close_files (2022-07-11 15:49:56 -0400)

----------------------------------------------------------------
Notable regression fixes:
- Enable SETATTR(time_create) to fix regression with Mac OS clients
- Fix a lockd crasher and broken NLM UNLCK behavior

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Decode NFSv4 birth time attribute

Jeff Layton (2):
      lockd: set fl_owner when unlocking files
      lockd: fix nlm_close_files

 fs/lockd/svcsubs.c | 14 +++++++-------
 fs/nfsd/nfs4xdr.c  |  9 +++++++++
 fs/nfsd/nfsd.h     |  3 ++-
 3 files changed, 18 insertions(+), 8 deletions(-)

--
Chuck Lever



