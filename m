Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022B5B6278
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiILVHF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiILVHD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:07:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161C2DA9F;
        Mon, 12 Sep 2022 14:07:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CL4Wrt007741;
        Mon, 12 Sep 2022 21:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lgYDnNoPBWq85nwmHIMYzNR+chBD80HPsfblng5W/M0=;
 b=Q//Jzl3R9+iEBq1s/p4wKocJJS6M/XeDPH4EB1cVDd2FJNh4MTNLk7bAk4zoZBy+CsYI
 CfiHlHMDM/ox8tG3e+LcUzo9UbcIoNv5jxWyMZ5T276L6iBrMSpqyHKIrZ1Uojz/+kIs
 Txjd4Z1NBAq70ZB72FMT9d/0h4bJ8+5Vo/CXC31XdWMhqkprDyt2JRtjVw5/ofC3JH6g
 V6bcIHE3pLIegiIfkHEDzVqDg0WlICJ+nPJsXIDw5dFCv3FSZpGydJ7TVvPp7tYy2vLB
 KAC0eQjAU6CXj2UPUrIZUznBPyyqMz/DIUKRXYQ4CaN27MJso+TaRKzOKbN3bzfFV8FX Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4tcrvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 21:06:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CK4tR9016876;
        Mon, 12 Sep 2022 21:06:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh12ywt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 21:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNaOpZxpGyrUfO5kWEd5OahIWET7dZcQRxpyx89Z6b0FvolHGXpFvrPM1QbpaAvMKSeBZQeugrPZQymPJ8aT+tB4edVHqQ3Z8qMKcScklTsTInBnSybhJnX073SC8Z91evQvhMiaKli0ei42n6pNs3GpU3T+TeUWKt2bITRT20ugI4Z1hDMiFS1OAQ/TdbEgFYlvUer84Gp9Uti/rB4XVpyXm0hX7tJ1PqkA+VKy1GYXd5sO6u0aN3aQPl5XaHj/P9xC/Poa179GuWajxV7Mw/9NMbHtAvHvmwQAE1VTR3L43RSkz7k1c0VpcrLYAnzA+KiLSAqtEHN7CDzz6IKJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgYDnNoPBWq85nwmHIMYzNR+chBD80HPsfblng5W/M0=;
 b=Nsnkza7wwzR0C4U3NEVxEV90WDQE14joiaUIxlztNMW4Sg83jC15gEPj5KczlUWTe/sESvrfqiW5lijpSsZx27d/lGCH80ivSnlAU+18WPNf9MVpFOhvuHJf/ULuMIgRFgf8m6hQQzlIGao2H+inNsIzwIHcmYKG4nI03ecq40ph35OEj88QXoHwG4en61xD54OismKEcvp3JnUqVcFieEG88m+hS9+/FdJ5ZrdmLZQIaqzZYBjWy1VQCYUN8L+Mdci+n7qTKzbPJvB/etkalpfQQxvFWR17EXgRxHwt+UJuuWy09jD5wO43IdwVUkIICpqUYGlUjOsOR/mvsDEAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgYDnNoPBWq85nwmHIMYzNR+chBD80HPsfblng5W/M0=;
 b=oXVut8PzXqb07iQVsIGzVrwcocVahsgowoiSR+toACs6A8hiaQydNWufWZ+PSSys75Gqx6TUFn4OVkDrHcMZRnX0BQghwTsmgocof/vv3i5/h+xdNliODvOojPn0+YDVZBmazhvW5J2eRTBdIQmJ5sg6A8nU4jHK4cJy8X35AJc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 21:06:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 21:06:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD change for 6.0-rc
Thread-Topic: [GIT PULL] NFSD change for 6.0-rc
Thread-Index: AQHYxuuVyZ50TL3SSUWUd1wat3EmOw==
Date:   Mon, 12 Sep 2022 21:06:53 +0000
Message-ID: <EA5CCB69-FE15-4B41-9058-E2A608E7E494@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5350:EE_
x-ms-office365-filtering-correlation-id: 8c51788f-4769-497e-3e51-08da9502b846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCms40NVZLtiWk21q9WFR7PP+CPgJcVef/mWkE3SwHlWVZUAkdd4RD4NFnLjjOo11wc/KeUHRkNFnix7QrExSx+lG5UEQBw0BgXpeaICJ2azS33EwI9Y6zKLAcskAOCPJL8nhDflB1sy06C6Ed5CRSI23Fb1pu4krveve94mG5l8Uv6l3Iv0VQhk1gtFykKN5NbryclZJKq0Q0I1uDgLzSfN1N1fh+quhw+RW8NkiGEYc7QEAXwnmEsYeO5B39E1YUNNCM7V2kCs+n1GC1PwRnV56H1yPKJPObWE1u88SDONBbh4HNSmyGBgwXaLR3HNMoGJOJodFx4Z1vdBArqsJmgtx7btgQ8j0y9Ppd/vErk7KSCeCiIIY1OVHo4tRdNVjPOdlZgSwzQhJflJapWERsbAtFQrkcAO/T5MAg/+4k8JuKtNWSAZ17BN+DKgLDKipODfylDw0Q66V1pl3dy6Z/59LRkcZqIJPIhstWkoSENHFanM/bR67GvpuA4322BYAuAOizeFSSfIKyfGAy+uUfWhhEtj3ky4Wkrzi89KQ+o9grI7oD9Y+ufIPGIvhw8xpxDjjeJOeOogiQFaJigFO7mXEyb6+yetceHPpwvHC+O/RcI6cxEjI+9zbzlXqIjEEczScC+rFgv4TnuhKwuhJtsr2iu2y1gp1Mjgdj62NLzaYCkuVYlWM8y3I2r3G9BvYZgH1spL3tqAmHxWol+sJuRtreqRublLmwwRvo9FZfeQZQc3d86TgX2Go7eXVk2Vsf6Rp1HKc19CdByOHgB5l7AfYy3wstsi/V8yKsT0efpqLk0MLSsEP8Zm+ZeoIs7m2TOY0mzOHgH4prIkIkzcXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(4326008)(6486002)(122000001)(8936002)(2906002)(478600001)(36756003)(76116006)(66446008)(2616005)(38070700005)(6512007)(71200400001)(33656002)(26005)(186003)(8676002)(38100700002)(64756008)(83380400001)(966005)(4744005)(5660300002)(91956017)(86362001)(66946007)(6916009)(66476007)(66556008)(54906003)(316002)(41300700001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0eVxqTysg9cEndbM8jplJrQNuYJwKsDsaXPTV7wzYLJhhojwv/1suaU85dLy?=
 =?us-ascii?Q?h+98EdLuGiy4XweZhXcRdbSO6gy1cK+LBl5LYXlBRFzwRBUHHMYMzvjrbPrn?=
 =?us-ascii?Q?bcnK6drcb7X54k7TjoagEGeKog/+OFIlvlWywjSSkz09ImjoJoyBZ9tMJwEL?=
 =?us-ascii?Q?uPujM0na66rqls+E+aKRnTmUtib66kE2/W4UX3JT/B8saBtU9IYfeXgZhrBb?=
 =?us-ascii?Q?27WSltRUpmE51LzEA6W3vGF3SZFs2ZuoEZwhzy/cVxZuM9iPtbZyCiNR3/No?=
 =?us-ascii?Q?g16LM9eCffHhjA0dU2p0545n+CkjO0gDRLGvrTEoiG+F+YkICJnVmxeDrKd0?=
 =?us-ascii?Q?kEwKEE9Z8i+CecnYtAnxzFdTOrOxcqnQTcQBIw/vVKujjZsuUyNFew0RtyMM?=
 =?us-ascii?Q?jtZGWM9YA8WP4Y4aIG1ellzSDf7emFiagTDBKxVoQroGSX4cXFR6aTsmpalX?=
 =?us-ascii?Q?QUoc7py6EvU1W/3udGuefmJJEF23CnoWGRSpyZox7SNJQ0cRVhgMBHFuF7Yd?=
 =?us-ascii?Q?Q+ZmGDQ4Dg+4A2WkI4BfoUYtB1KXP2ipwC4aVKVOtvCfMpub6FhYtfq2jpk1?=
 =?us-ascii?Q?tRWHCKno1kda+lL2aGxU35DdPsVKeb+G15L20BUHNEP5Mk+Cl6rJSQSOexIj?=
 =?us-ascii?Q?+zsvDTdc3bg/ypCV9fP4veG/jmpygOyjZGadBEl4hn1RLCgFAUpplnn8qYEP?=
 =?us-ascii?Q?mFT9PaUHWcc1Yiv/25f0/C/dxBDtnbpuN9TY5eCmxbBkt/AgAOWRvFLcQowG?=
 =?us-ascii?Q?C6Z1g+Amw/OEbKyTnlK+lIimPRdPnI2iI6UbXhQs7hdqjy3tDDtJDqUqPa57?=
 =?us-ascii?Q?TgZ+PrH5X3Ha7E0UKtIDCHs0g8vvkmX8DL2UfB2Mfxw11jQ/5PqS6yyb8uNC?=
 =?us-ascii?Q?kUU7OCghSG3Fdm7CyPpCrETQjTFr76E7F4r0E/54qa9sHmIIBoT8SCsa0c9x?=
 =?us-ascii?Q?GVGc9ukeKAiUVDYLTXWUx/Uyu8N0y8oPfwG+8tubdKIfcGEXKxOhPMOGRKas?=
 =?us-ascii?Q?hBenZ55tP/nxu7D6auudKanZk15yIPG7j/fbBDPfVjzw/oAh96AkVFpV4U64?=
 =?us-ascii?Q?5gVajtw2TgxT9zH8A3HQIx0nxQe3G2oSmwuHcRJWBy3hdNLfIK/zTdq05Ret?=
 =?us-ascii?Q?j8FvBhFoP0B2k4pu6MJ9AHXzfNwNtkKy4WGCSGL9OPoDKKPUOpavsBdMwnOJ?=
 =?us-ascii?Q?NfCJ8TVy1ZMdoFgLS9AFxgDIFOnoizXG9p26IC458NjskIj9Euvs/vabboke?=
 =?us-ascii?Q?r65RmQCI5csuj8uXY6X04CA7kNXfPJEZ0ojcPee1AbwtiUXNSiL6GGmyZvVH?=
 =?us-ascii?Q?xaVMIzGsAtZXwSGmAsAqc2v2twtaCEPxfs/V74T/LbiA4Jc9AEhTjuf2iHyo?=
 =?us-ascii?Q?aUpeko+1EfRodAzYY31h7ufo+VWWDs4BNekEKUcemYD3/raOyX2VxiKTMWxb?=
 =?us-ascii?Q?Dg2qsyqgZLFR7jwQopFsRYHR2pKAsVtnNeQ30/SvVOeifYeP4gVTABavEyVy?=
 =?us-ascii?Q?aG+Pt4bpjXL/Tez7bnspVOEC8VdtX0p+rA891vD47KyhDQMeUqb+M+FpArfG?=
 =?us-ascii?Q?eXspXHK7aM7E214t2ylNk3YOKW8nppTY3X/vFdwVl+XXxhwjhYIgN/zdTpil?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <247AAD018B5434459E3D4BD4715EC529@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c51788f-4769-497e-3e51-08da9502b846
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 21:06:53.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yv5NQbnYb5KiiW/4UHAXCdtpcFNbQXk1p1VFlJd90j1tyk+wozg2q619UDDFcDZ8cxw8XvJ7lYJDVKQnsedfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120072
X-Proofpoint-ORIG-GUID: twBraVjMqF3dIQxdY5UfZzIdh1CiFq_B
X-Proofpoint-GUID: twBraVjMqF3dIQxdY5UfZzIdh1CiFq_B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 6930bcbfb6ceda63e298c6af6d733ecdf6bd4cde=
:

  lockd: detect and reject lock arguments that overflow (2022-08-04 10:28:4=
8 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.0-1

for you to fetch changes up to 00801cd92d91e94aa04d687f9bb9a9104e7c3d46:

  NFSD: fix regression with setting ACLs. (2022-09-08 17:53:24 -0400)

----------------------------------------------------------------
Address an NFSD regression introduced during the 6.0 merge window

----------------------------------------------------------------
NeilBrown (1):
      NFSD: fix regression with setting ACLs.

 fs/nfsd/vfs.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--
Chuck Lever



