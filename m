Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78862641E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiKKWCh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 17:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiKKWCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 17:02:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765DF006
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 14:02:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomsP025515;
        Fri, 11 Nov 2022 22:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RdldSya34Mwd9ojpBDDZOQLhvPiTWTdySazhUq2KNkU=;
 b=i5o6TMZeuhGrqvZomHAPyJzO9HXekIdbNJXUNF/tpcS/7tW2sg0o3+I3i2GT+TbPMk39
 JUMnTJnlbEVeQNOQKKa4S8iBYMVbf51xo4RR15h5yJFPK4g8eqlmUVtcg4MgXwwiNKnz
 ZcadHqZFGSHhc8uUdNJMRftbFcEz/7Iq4bmVHC0+q7Kog9+FlSDRza0Tkj6fsqtxKrNd
 kWyRb4ecebdnsF/Vhb4YRJbztCAAcuZSMvnzw9tP20LyuhGOz3hHjs+oHdrxrBM096gw
 NbJzk6/oXBecdUn5hgrq0KIN2xZiiU/HPWbZf+dlnRhvl/VkDcZ93YljgtX61A/FPGPH 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr0k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:02:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABL07eb009170;
        Fri, 11 Nov 2022 22:02:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmygty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSYTi7Fnp+rz5/a89dBbT7/rilMqA0HvBaMDJ1yW6h6TCK/GvJ6AqJ3nUDmYUdojXUTXQ1BsiNfDtImCtwgkOnCFwrcsh9O4GgzD78Sb4vBLgY8ydn/R2HbAR04gYtBMR+tQkmJGaAZIjvEHenoV7BVlwTV2bCEmakdJwBnIEffNxezS3JtZlCuvM5xStp4kkp/QheeEvFw90foTtobBL8nxaCPt3yJs/c53gwrLZBlsjfFbdGpB3XbWHzaNb9p3A41Wup5y/bDHzHgFyNHTNTk4Tzb7h/XHVxp3QNxZsVZP+sQYlfYhjG/IvKCid9UmL6vQgNp7j7xvGbSlzUIWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdldSya34Mwd9ojpBDDZOQLhvPiTWTdySazhUq2KNkU=;
 b=BVCWxlGRfLgVEKprYinJBsQsikc/IsLQ1eZQAoLVSJyJETRJIBjzQ1FSqfty/G8VpjVm46H0M7k3r0swtnM8uFX/t1vIyGPFeMa2RdYSE3g6jhgYhLyTeN1+531Gb5PeeHchiFbj9BP4t9r4DOV4uR9ufXdKHViYt/fAKqnqD8U0jeKvCFxrJnF9r6YQL766y7Ao7b/JOgOcPNC3/w+LvBPAS3uAh8fGmcRU8SrUowg+ekz953leTnm63+aNRymtFcf6QX0K0DTNzJ7RBLuRux69DnJGxns/3Lcyw+3dMLObxfjE5su0CuzIItqtYRb3D/iMdrbZpW/Y9QrEvHbAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdldSya34Mwd9ojpBDDZOQLhvPiTWTdySazhUq2KNkU=;
 b=CCetUR07Aj2gO2dClppGRcqCVBKyZHXjtS2cENaQQzWycdA5GFizAN+XpG+nvmOkXJ7Sl8cP/Uez0ekpgTNtHxlc7nlTNPG4nKoOQKwRxIEAr8BDPGsxaOvTxOPyOUlQEeToKUZuR0WVeFJPegOB4STyhgCI7aQLUlWuqHbuIWs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6260.namprd10.prod.outlook.com (2603:10b6:208:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 22:02:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:02:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Topic: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Index: AQHY9LtZeVXT8D2f3EuoKPtp4QoFca452jEAgABnJQCAAAe+gA==
Date:   Fri, 11 Nov 2022 22:02:22 +0000
Message-ID: <7EB6DAE7-6DF9-4013-BE37-F7BB2ACB19B0@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
 <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
 <b6901519-a423-566e-f447-af8590ec407b@oracle.com>
In-Reply-To: <b6901519-a423-566e-f447-af8590ec407b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6260:EE_
x-ms-office365-filtering-correlation-id: c605a5d6-6483-4a54-c936-08dac4306919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7lc4Pg7y+OoQIgHknbFyA3IF/4dA1y+X6IZq7OhEGrZ/lrXb0gWgoyeQyuyr2iiWt90HgVRCNfSTo6FR3A+nAB0A8b3HmGe8HVaQ6r0Z2SkHCTPE9PPg40451cBKL09DvivDhdMtwMxfudMGT+l3WcGdbichnXvAQXN+kYUstXergi8aR9Iue3I+AlMYVkI4IFHEAg8azArJxViknuD/8WImhlGhKodnAbHNUszLWfki2thcq7bI5MqsmAPCeENHyubiaMn8dZvvTVtvB0Y/nG7ccZWCKq1Eyoqdjskf046rr9XX0Q/Rb48ooc00LKhS4iRmFVrit9Y9kwVa5m+OXwggBK3RJ2/Unyupb2bYNbSUraJbxHwYF2e791E5OnUDcwh54fGDla2UA/YgNEmyBHpxx14G4hvmJYSxzICim3EiyrZnw1EyideNZe61hR6npHzKGa8Rg1yM1flnTXlscZL4eOJBlCiHA0XNLoVgDC7I4wtRDALUMDv4IoADkbbxBpG2fTf2U5tMLMqEtkVrrD+y6dI+b0ZcY7LI7cCx7qVI9ZDvT3fGgP/gkIzXDf27DIpro3jcGs7qIeqgoahmPELziy8OUOy6jNhKjiZeBrO9xeMJticjaQmPAOBgF7FIMVSP4Td51kzTEcEn06AgVQ9qdQW+eH9uCg6HJmWPUHr6+ng36tuQePyVG6hoL2QaE84yCxkIo1cGEfAEI8eoiXKf1iRDTeeiqz/4diqz3B4sRw9LHbhYre/x9B1xuFvyaMhFJITPd0WiKCVPKYD65KcaKN0qPc0yFo1gk7CHeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(122000001)(66446008)(6486002)(2906002)(36756003)(38100700002)(8936002)(6862004)(5660300002)(2616005)(38070700005)(186003)(66476007)(66556008)(66946007)(76116006)(64756008)(4326008)(86362001)(6512007)(26005)(8676002)(478600001)(53546011)(54906003)(37006003)(6636002)(41300700001)(71200400001)(6506007)(316002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+jcK9dHpCq4j3TKBW1e4Fd7wUPC5tGx5X7sNNZZsIItavrYsjEoiuL/K8V83?=
 =?us-ascii?Q?7uefBlONig359kVdsTzhnZwREOrTrjh6NKO4htGRx3znfOveVfGoGfavWfIm?=
 =?us-ascii?Q?T1MjdMxL2gY7graoAd/mUvJhtbxxYGp5lVnJfYkrZvFbKhjpAK7iE0IYZXCD?=
 =?us-ascii?Q?am2Qewq70EzjRInrPpEifoUCj8nJ1YEicy5BmZ2sdEjrLmM1EdimPI1M4dJ7?=
 =?us-ascii?Q?xbW0laKOwUErUHQi7Mqzg7wmpTGPP5ZEPF9q5T0gc/hxZB2L5QQ9ib3pM8VK?=
 =?us-ascii?Q?oAK/EjO1d4KEm2e5RftMQkwauv1IR25Om+dS13KZflKs4qHVZRboSOJYFdAk?=
 =?us-ascii?Q?hfCevFrqFUXjduH0rrw5YJRg0Zqz1UoQez2DFQwwivpb/yAPjmHgNC21NpD9?=
 =?us-ascii?Q?7cf/+fCmV1ZU8iJXZSIua9GD3N2Z1Y/PkJYeW0egEs65a34vcdoLMG1Dpkgt?=
 =?us-ascii?Q?dUMewiRQVjAYn27ZCJSB/O0KJNQ79+UiCz9YmN6PJ6ZmRloynPCgUa+fkoM7?=
 =?us-ascii?Q?K/tRDSM5HIiyzwv5EZxEv6KDLaKNtVf6oeSe6PdMSZKvyy0Di+9yonKkzx4s?=
 =?us-ascii?Q?rhKcsOcT7GeJn9QX31XNEq7TV1ApztepDlYvm8oNUiA8lio5TT3dA3A2w0jK?=
 =?us-ascii?Q?TPK0JUkN6PGxYhRlLqm0rKLbB0FwBUX8oRziK3Zhsk1QykTk8SFD9REKdkA3?=
 =?us-ascii?Q?fxOhym7xUsjqZqOB5RsSBCb+dzS5Mw8SL8DUjAwL0VJNxZBTfE8F0NS75eri?=
 =?us-ascii?Q?xXj29fS3oFBR69ScrvR/DNuM12fYKItnWDLRZo9H79+K2DGBxRRSGRMQze90?=
 =?us-ascii?Q?VgfNEHA/w31GR6yk0i4GMxDxm/loBMrZtVmIitvEuvyMJipBdwQavRROft7W?=
 =?us-ascii?Q?DIcR0luyTPfR8WZxCgVId90Hk5WSJGwXpS0h/qPof978tu5WrtTAHGaNcZXP?=
 =?us-ascii?Q?tFgIqzw633IHF6cUiVr91tQCOppv88D05VsRvsZrbDXllbV2DdZvxAxXHTOO?=
 =?us-ascii?Q?D/DzsTgXcE3IFOwxwJP8GqO5OkYKu8/U+Ry8eAERpVrjQKgM6h8LFmoSWsrc?=
 =?us-ascii?Q?04aQwAccWsAoPhyCTaObKRB6cB8cYnFfFVBEH8NbMfC7HHpj/JPFZN3AE27h?=
 =?us-ascii?Q?O1Q6ov2HOdTD/WoNa89K3ZuxTbLOYIRhXXb7C/fkWv+sqxyY6yakUjT9ukXO?=
 =?us-ascii?Q?DXCrAKSQ8cX4sse7/fyKzZgOKC/nBDXXt5ayd211tj5//tJwjkhTyXg3P6Vj?=
 =?us-ascii?Q?E3zGsdsodS5dbwFXnreA/NmQejeqZoDXLkHGmMcfBDx9o3GaM+SXsel1r65I?=
 =?us-ascii?Q?IZf+0csfM7bpiRiwE+9kkHYOsdZ1Xk4MsnLrh5LsTMW74f2rAMp4CQN88zx8?=
 =?us-ascii?Q?YWF1ELXVDFIkVG07CkeZLv/6oUG/m+6QM12i6LTZ8Pl+OOI5jh+HMVgmSjBu?=
 =?us-ascii?Q?TpyT5tkszT8rpCN1n7H95PK6SPkUIAo5aXQMSgxoskrPh2Tyx4bi8DLgjL4B?=
 =?us-ascii?Q?UT6NEZetpMqrwpcnR03QVHq3hE/KAHRuyfW8ZJpgo8uf/2nJWIf1T9NlfS3f?=
 =?us-ascii?Q?rVj3t8FbBgeW4m/0vPsJcdbp6/ZdLA4hTh8HbRFJMpAfll32cqSYrQdunmoX?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C75C91526C82741B1B8F308489BE59C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tKJYHhC8DXGDKXGTOcLGtePMfQbn6Qs60R9uQz2K9pC7VE9PgfXsVrQtPrruBU0Ooq/EzNH2MUx8y18FRJ6f/AXqWRXJsrUcAc7lbdHjgR4NZnsIbQ3iAAcIYAGgGrJTNuHbsXoTtbf8oG0fG3eloJy0irPeOsMDkktZDRbcAUW8isKXjUL4KUlbzo55srMNmbDrk8LgR0F5I6gx4kC2jV/Giy7oz5T0BUkST40beeU10xtOzH47TVL+g03XlwGwO/g45/Dhtw9Mh1xJ3KZyMRsH+gf/5H8NBXE3fwBP/B5QxjJqcjEVC7CwUm6fx+8gr3kwLYYeU3/4SIf9KiMLwfH9OGKaCa04ffsEWnK4p10Om/VUDfFlLTDdim44d+p4bCOd0UVjXnHVhpMvWsjgmPdPrZP5aUIjMfggWMS3xjABJf/31wEo/8PuwAjpHtdNNPPVtIJCzkiliK+lX4yPONmhzcFu/eo8s4xboPYZFg20ywCcBvzFrTQhDW23Uo+XF+O84ZjlAskmaWSsB40CaH7Y//bH5lrnGt86xuP+bEIFf004B0OxUsUtd1zwjRLI5/LIwnFAM30AX82s3xKWkw6g1WFng6eUDNA9Pw6VDLhd8xG895nMV17ctMSSY9Uf9yA0/PUPenVW9tXVOAIOj1XvyODCp0+vFQk5Hf4RKPCyZ+P5UU9rC3WlRiM22v7Q09nAge997BAQKBzmKl+G0SUhf7Bd/3MwrAyDH1O9tXRHeu0aEuA+NT2n4qZ4GQjkgFCEw8u8taSm4tvxMT7nvkUBBB8k4e8/VOyLeQv+e38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c605a5d6-6483-4a54-c936-08dac4306919
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 22:02:22.6493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5iefbChc08s7TcfutQXAD2SUiURM+2VJiCzkygMGkhKiGln+lVbYXyLt/vUO5od8eoLoODZj7q//L7KkRQEotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110148
X-Proofpoint-GUID: YJ0UvvQOBB-fbwpxlbn5RxVrr13mGUAx
X-Proofpoint-ORIG-GUID: YJ0UvvQOBB-fbwpxlbn5RxVrr13mGUAx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 11, 2022, at 4:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/11/22 7:25 AM, Chuck Lever III wrote:
>>=20
>>> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c |  2 ++
>>> fs/nfsd/trace.h     | 53 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>> 2 files changed, 55 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 813cdb67b370..eac7212c9218 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2859,6 +2859,7 @@ static int
>>> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>> 				struct rpc_task *task)
>>> {
>>> +	trace_nfsd_cb_recall_any_done(cb, task);
>>> 	switch (task->tk_status) {
>>> 	case -NFS4ERR_DELAY:
>>> 		rpc_delay(task, 2 * HZ);
>>> @@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
>>> 		clp->cl_ra->ra_keep =3D 0;
>>> 		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>>> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>>> +		trace_nfsd_cb_recall_any(clp->cl_ra);
>>> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>>> 	}
>>>=20
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 06a96e955bd0..efc69c96bcbd 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -9,9 +9,11 @@
>>> #define _NFSD_TRACE_H
>>>=20
>>> #include <linux/tracepoint.h>
>>> +#include <linux/sunrpc/xprt.h>
>>>=20
>>> #include "export.h"
>>> #include "nfsfh.h"
>>> +#include "xdr4.h"
>>>=20
>>> #define NFSD_TRACE_PROC_RES_FIELDS \
>>> 		__field(unsigned int, netns_ino) \
>>> @@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_do=
ne);
>>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
>>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
>>>=20
>>> +TRACE_EVENT(nfsd_cb_recall_any,
>>> +	TP_PROTO(
>>> +		const struct nfsd4_cb_recall_any *ra
>>> +	),
>>> +	TP_ARGS(ra),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, cl_boot)
>>> +		__field(u32, cl_id)
>>> +		__field(u32, ra_keep)
>>> +		__field(u32, ra_bmval)
>>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->cl_boot =3D ra->ra_cb.cb_clp->cl_clientid.cl_boot;
>>> +		__entry->cl_id =3D ra->ra_cb.cb_clp->cl_clientid.cl_id;
>>> +		__entry->ra_keep =3D ra->ra_keep;
>>> +		__entry->ra_bmval =3D ra->ra_bmval[0];
>>> +		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
>>> +			sizeof(struct sockaddr_in6));
>>> +	),
>>> +	TP_printk("client %08x:%08x addr=3D%pISpc ra_keep=3D%d ra_bmval=3D0x%=
x",
>>> +		__entry->cl_boot, __entry->cl_id,
>>> +		__entry->addr, __entry->ra_keep, __entry->ra_bmval
>>> +	)
>>> +);
>> This one should go earlier in the file, after "TRACE_EVENT(nfsd_cb_offlo=
ad,"
>>=20
>> And let's use __sockaddr() and friends like the other nfsd_cb_ tracepoin=
ts.
>=20
> I tried but it did not work. I got the same error as 'nfsd_cb_args' trace=
point:
>=20
> [root@nfsvmf24 ~]# uname -r
> 6.1.0-rc1+
> [root@nfsvmf24 ~]# trace-cmd record -e nfsd_cb_args
> [root@nfsvmf24 ~]# trace-cmd report
> trace-cmd: No such file or directory
>  Error: expected type 4 but read 5
>  [nfsd:nfsd_cb_args]*function __get_sockaddr not defined*
>  cpus=3D1
>    nfsd-3976  [000]   410.956975: nfsd_cb_args: [*FAILED TO PARSE*] cl_bo=
ot=3D1668201586 cl_id=3D2938128369 prog=3D1073741824 ident=3D1 addr=3DARRAY=
[02, 00, 80, 93, 0a, 50, 6f, 5f, 00, ..]
>=20
> I also tried Fedora 36 and got same error.
>=20
> Can you verify __get_sockaddr works with tracepoints on your system?

The user space libraries still don't have support for __get_sockaddr().

Assuming that eventually those libraries will get the proper support,
in this case I'm willing to take tracepoints that don't parse.


> Thanks,
> -Dai
>=20
>>=20
>>=20
>>> +
>>> +TRACE_EVENT(nfsd_cb_recall_any_done,
>>> +	TP_PROTO(
>>> +		const struct nfsd4_callback *cb,
>>> +		const struct rpc_task *task
>>> +	),
>>> +	TP_ARGS(cb, task),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, cl_boot)
>>> +		__field(u32, cl_id)
>>> +		__field(int, status)
>>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->status =3D task->tk_status;
>>> +		__entry->cl_boot =3D cb->cb_clp->cl_clientid.cl_boot;
>>> +		__entry->cl_id =3D cb->cb_clp->cl_clientid.cl_id;
>>> +		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
>>> +			sizeof(struct sockaddr_in6));
>>> +	),
>>> +	TP_printk("client %08x:%08x addr=3D%pISpc status=3D%d",
>>> +		__entry->cl_boot, __entry->cl_id,
>>> +		__entry->addr, __entry->status
>>> +	)
>>> +);
>> I'd like you to change this to
>>=20
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_any_done);
>>=20
>>=20
>>> +
>>> #endif /* _NFSD_TRACE_H */
>>>=20
>>> #undef TRACE_INCLUDE_PATH
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



