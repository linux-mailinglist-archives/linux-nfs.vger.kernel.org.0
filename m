Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697066E422
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjAQQyN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjAQQyH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 11:54:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC9F1CAEF;
        Tue, 17 Jan 2023 08:54:05 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGUtuN025981;
        Tue, 17 Jan 2023 16:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MNz+YloPVmn9DZk5ojIBMWS/THS0a8qVpvaZAGQYnj4=;
 b=ZteaerNdxuojlNZcsWKzTM4cS9qBTRDqCjnWHMWD9MQaN4JWSnmjjyUhHpE7OFIOVNya
 lmV+8Or5OcXZXdgQtudJ3Ifhq7CslF4ubwPkxXBScfkDqfpLT/zVGT78z0ezGuUZ20cn
 3cWKIP7BZASNYHHmPkeSSiC85eG1PN8w3l2pEALvl1hOfbUP3xSSjZvMXPI3plRaVVeu
 jauTDx9B2+oJlQV6ksIns5DGtHXOFWaA0JD2FVZWk+gAh6KfwZXy4n3EbZG5eJCGOdGd
 32U52TzBsq1oQuKFAODwJAodRK+nuaYJFYxCH+7k9QclvFNXEz22ZSF4Gn3pdwYg/Bvq Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt59uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 16:54:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HGo8J5004862;
        Tue, 17 Jan 2023 16:54:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyyvv0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 16:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiJh4M9J6MdY+aCza7IRQ5Yq8DdXwLqrSIGWw509m9xelVXz5vjqQmReLURz3WayoqXa1h2ah/qEGu/55Lcc0axVjGGx0wdFDSaS4UZmUAHWwwO6wzGsO2XzWzPQATHGb6YsWdjvcAgt1zUJCThm66sqJTyB4j6RNhmCcjALBJZEcx4h/aSdTZ9TTWkXpGqY9CycRVpuj0jnLqPwB9tYviqq/uge2J/+nR0QBTUyPSQUbQ4tR81VK/VKAhFXdqG3ZAvDizMgXapFcJYWHyya1k+e+j3Y6OCw6iDSTsuk6zpW5jSryC0PbJ+I7miwbHthINGbdBrbdR/5gknubt3Hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNz+YloPVmn9DZk5ojIBMWS/THS0a8qVpvaZAGQYnj4=;
 b=mQPYZvu1Hp9Vbv8ZFvNdo7724TXUJOzevKEyqYdIV61l5KtUM/c1PNF+u3qv1IijSBYEadCPeCXIWJY3rUsa63sEnUIE90+KseTmfgpqybxrKlOVfS5CvMlJgb2+gquKRZwTlkPcjT/9X/7q1v0o3UFKyBkBULw6q/7kXOQzpAyjUiLvIWiASB/RSIPuiAb2eFozhP/nMZz3k0xk9N8phAtszMEVHucJr7ICVSuN3KUb+Td8qcZqZQ829uWVmXb+/oBVs/hX9hvN6hvliUE4ELLDBPseGaLMnmFH/K7oLc/iAqVoGSweVBWWduVajWSZdj2vAT2vgaMFBYokgxUpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNz+YloPVmn9DZk5ojIBMWS/THS0a8qVpvaZAGQYnj4=;
 b=YfYDIHQwAd3VXERcwUJ+jpw6MHlLwF51etekrPzsgsR2JiNFqG8mg4KU6PHw0S31zeAlAcLP1hU+1KHwSRSHtRr4G+1WM1OW9kWpRisbZp0l2tsrwQM7MMOsOtCVK/4Y4HNj13/leoZP1R4eXGBcL/4WlY6HV/dVZ2kv6xZ7+8I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5288.namprd10.prod.outlook.com (2603:10b6:408:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 16:53:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 16:53:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] third v6.2-rc request for nfsd
Thread-Topic: [GIT PULL] third v6.2-rc request for nfsd
Thread-Index: AQHZKpRL8pwNShpcN0aQdSJGu+d73Q==
Date:   Tue, 17 Jan 2023 16:53:59 +0000
Message-ID: <A5F12427-0E66-4650-A3B0-D2FB5407401B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5288:EE_
x-ms-office365-filtering-correlation-id: 02e2862d-e7a0-43da-a151-08daf8ab6e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKvd5gDYjdzteBzNNu4LO5WlypKQHTFttTDMevz35ZlI+B2wqS5XqRB9XqPCjH/7egk2/TNmrPSHQINQN6R3A0C4e6WxmB8ku+VM30iUDYlEZnmLuETOF7zZuxd+lx7MI8U7aYF4YNx21PvEhfqQVVQyYYIiOYN5f8ov2+W5A/B3BSZxX9zGaJdV8R/Y7hfVFv0+QFC1QODSLVZZq1ylSM+EABP4BA1joem5Yp1Yh6hBCsaTmC5SCaGUV3irRvQknpzykV0va/fzBBkxLt90oYcjEassmsVZMQVJGvNsZDMbdo5bb9fqnWkHmOLyITuVgua65MvK2XRru1bU5QrcfZN2gcwDih4Jb84yyxSiQ0gvmqWVMko4i9K7eLcQ/SWagto8DN5IhU74QPi5reg5qSQxpihMtKIg5Lj3Zn4IXCFfzuJoiuF6PIR9G4eW7bV+5P2C01Jt7JvcQxVNSR19dXkNjLRR3LNHKR4tnqfpFA2Q26mNYA+GEAzsRoq9wJx1tFbHe8Ug3fwUV92UV3o7pRjPm5+r/w8DotcTYMAEUXgAGCi6LWzDxHmaS03/ibVflbmx4qB0q5SZ00zxyLyoqyBGUPga7ZR77zliAI0voGUKLuthAVCDizHdNO+nQTLQvHtpBuOcSxKJOMcp6YjEsw/wvPlIhDcw6BHOqdJxsgnp4H/orV4sIkZrkr5e5kWz2XzQo8XOgV7/9CjFBwgZ8WsFkQLsUjdDrDrM0AYcHesT6T5VbPWbZLVQFjI45bqAOsLWWH49i84w8jWnyGaHCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36756003)(33656002)(478600001)(71200400001)(6486002)(6512007)(54906003)(966005)(6506007)(26005)(41300700001)(2906002)(316002)(5660300002)(66446008)(76116006)(6916009)(66556008)(91956017)(8936002)(64756008)(4326008)(66946007)(66476007)(8676002)(122000001)(2616005)(186003)(38070700005)(38100700002)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QeyRnZEwPNEpCwY/9EAOLCzsU21apbMLB+I/i/MQe/nu6HBox+UFtn5lmO8A?=
 =?us-ascii?Q?3w6PGahrZYvKCyJNvz8GxWhn2oTB73wIjf4laQFTXt9HznLbo1qO1/0rZbxn?=
 =?us-ascii?Q?82zIIfpPhxv30ZunAqgYVQEncPYQJCDhInK8brrmWWUw7cLX/MMVC148Vv8O?=
 =?us-ascii?Q?vEojMrDcv3tVe0QfBEFZGLyzi4drk4PtOgNUj4iuK9CymZ9b07G9HgG5uMAh?=
 =?us-ascii?Q?wj/6XZ2xtk1OSbhgdmacLIyuyPLbnxAfwlsGg0G7rB1efNbuvPieB4ssyQm3?=
 =?us-ascii?Q?FjI/p+9DcrU+d02QEKYHqiIF+/Cc6xrLpZNuWu9q9T68RupYrVYM1Ky07Ilp?=
 =?us-ascii?Q?8Krr2ax/HHUvtSy3yCJlmS8+CEjvP825PuNUl7nQzt+INN8wRE/fJOcWbsYr?=
 =?us-ascii?Q?FRaza2qjjQ4X2mP2v5lUUUgyJtUKYMppvv4oW61AE/WHYzt8AhxqlYFNkQne?=
 =?us-ascii?Q?Cr77keA1p3B8dqwHY4t/Is7WhuMWYDxzOp8XJHYe+g4mNThrXho5kjhk+ouQ?=
 =?us-ascii?Q?4Y2RREw/9/NZpljPymDdr6FlOqeOQ2+ReND8N2Hfn2aM3jfwyBcMsY7GBT7H?=
 =?us-ascii?Q?UMiQHzXbXn3vh3v9h389Nd3x8M329tSyLascrvR7c6tvo05sfAnLpImk7anV?=
 =?us-ascii?Q?T3lvH0ODEThWpIRnifoGfqTn6x/G/ZhvEaBiJ2w9Z0EIiZpYQF0CSXrCbOo7?=
 =?us-ascii?Q?kGHDys/XVEJ7ZtBMGceqqH9Tt4PF4eZERdAoFGhKcowRrhY7mdZo/mL1WJ/b?=
 =?us-ascii?Q?BpCYwZgocg8It0Ngc/WnD8ARTcoLddaLWbiTr0zBy8iLjgNJPy966Sm3SIcK?=
 =?us-ascii?Q?CJ+rqWG63yJIWrs1RSwpmj3y88MDL7bziuFpGFU97A45SMwDDlZDmCd5uctG?=
 =?us-ascii?Q?pZGkVp0Vj5hsKI1MfKM6VuKF4dJHVGxLaBVWDJIg5Kwto3TH1cOk6gvgJkWA?=
 =?us-ascii?Q?1JDUfxMKgODftu5tpidjcZRmqnXlPhU1AHtYY7DIKlB87tC+AYN+WVmSOtn4?=
 =?us-ascii?Q?4kun2MWm7wxZh6AMCF2PpI/H9bfvyTq0NByDqociuFHvMEop4mdefWO/mAPN?=
 =?us-ascii?Q?I6DW8QxWpMkSITMw3LFrqWm+2jcfh/Xbjj2hslM2nRD4h0JW6lAWTMsAnjQ7?=
 =?us-ascii?Q?sPFreSj95cXIb9CmLRnSXenKuxE8QPLeH1moKapAa9lLN2wsFXqdNZpA7bkg?=
 =?us-ascii?Q?Z2i8AgzECiO9VdVQxbT/7IwVRqh/y1DukhWtazkfSnB0W01gJ5B2VaMmTYQZ?=
 =?us-ascii?Q?fxDhWnQq8WpF+cy7bpg1VTl6g7nylWRvircHlcyR2bqu218oj7w3vQ9uNNxy?=
 =?us-ascii?Q?DguOvsWulp0YF9xMUK+ncoHYwh1Da3zcvRYGwI8/sJN+isW0faz2tnM2Bmep?=
 =?us-ascii?Q?fcSHdd6PI/Exq+TYFPsWeaCrME2ZLGwk2TJ34mFZ2lLLwD6HTPecZftWsNis?=
 =?us-ascii?Q?I73aLPIGDSGHgGgnfxhXZbXKas8QS8HaWh9DVu0QcGGPf27yypynqTponeTu?=
 =?us-ascii?Q?agxo9Eb2VJrmwbzsLSQcFwLkY5nXBhtatrxlOG4iTWYOVzEagta5lchjYd/J?=
 =?us-ascii?Q?PvsS+D5npq2muNjK33CzJl3Pg4FF0DNwcQ+2aCyk5QuW4G6/PJbBx2VtEa1q?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1495F2631BDCA748AB7852EABF9937BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jt7oX3ubrIRY0y7WjNJdIUO8RRAXd8By4TCo0WCbONzxxLWHyO488SQZkivyLb2CxMYyjwxeln7z6ldD5sGt2kKcRAr/GODVPtEMDr+GmfpJnChggAe8CAYtTS8+xVqoN1VVbYoh4hB+COIBXyX4RbM56CduQn1niv+2NFrNyWwlG3asZqL3iFNHjceBXTxhVlyUSsswu8VXgquNK+q5QC0Pw6fqcVC4yW6Tqw/6KXGJYkavbkf4c6fw9y6bPugWnsmMvBCsREvD4vpaWuLbS/w1Bi80NFi01pU5RYjphsOSCjspknESkXEB2XAX//FCYKw3PFc/oqeAZPkuS1z81+4yyLsT/6koaYcdd4sK4/gbiwbxfoXmb/qYV4hy0RSdA1VY7mQmAPCCWP0I5G56vOARDfsKFY4KuxPb7YI/YVCXytNJPJGYK49SwIgGxIURUtdqNtxh1OdhBiXkUji+/2CaDD8w6LjeaVeGA4wDLlaJq+Oe26OWLHITWiFUs3ktrSAfu1nRjCRIkGrc+OblyS20vDN1Jm3T4Wa8knctpCkkO4oWq3sBxAfJsPiecY6FmSgAZnnH3PtucOsWjhV7BnzT9/4WhJ0flNQewF7fQvUnsbMX/467Bu0Eba/bCavMFv2ZZw2e3fy83OYwH5iT49xxylZK553ofeC3Hgl+LMqHyQG4MoJQhlo6UiVJm7rDlLaN0/YdXU6tb4rFGWS51cgn045nLLD0X4WePDKKo4h79LcDMR/3ETgkalku/ZDvmBR5mPN2DvYGYbiHetOEIC/Zo+Fypv5Rap4llZ+qK20fc2kzEBSpq82u3RRY32xoq3qDO4sXITueM2Yr4qRBb2R+IMYp4tymQI9ATMZOAdc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e2862d-e7a0-43da-a151-08daf8ab6e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 16:53:59.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8lT9AH0cSG6rF2aqfeAHN30UtCsZHHk6q38F2ce/hce90UOEtMnuw98/VZOHtRXF42YyAL7lcM8GSPTku1Zbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170136
X-Proofpoint-GUID: u7hdu6dHhxwD3SBNpHkjSLTl8hjPTvdm
X-Proofpoint-ORIG-GUID: u7hdu6dHhxwD3SBNpHkjSLTl8hjPTvdm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 5304930dbae82d259bcf7e5611db7c81e7a42eff=
:

  NFSD: Use set_bit(RQ_DROPME) (2023-01-07 10:16:33 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.2-4

for you to fetch changes up to 7c24fa225081f31bc6da6a355c1ba801889ab29a:

  NFSD: replace delayed_work with work_struct for nfsd_client_shrinker (202=
3-01-12 09:38:30 -0500)

----------------------------------------------------------------
nfsd-6.2 fixes:
- Fix recently introduced use-after-free bugs

----------------------------------------------------------------
Dai Ngo (2):
      NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shu=
tdown time
      NFSD: replace delayed_work with work_struct for nfsd_client_shrinker

Xingyuan Mo (1):
      NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

 fs/nfsd/netns.h     |  2 +-
 fs/nfsd/nfs4proc.c  |  1 +
 fs/nfsd/nfs4state.c | 30 +++++++++++++++---------------
 fs/nfsd/nfsctl.c    |  7 +------
 fs/nfsd/nfsd.h      |  6 ++----
 5 files changed, 20 insertions(+), 26 deletions(-)

--
Chuck Lever



