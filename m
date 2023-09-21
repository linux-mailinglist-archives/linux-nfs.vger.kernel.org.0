Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F497AA569
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjIUXBH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 19:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjIUXA4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 19:00:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F8720D1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:33:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L9UnIP002785;
        Thu, 21 Sep 2023 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GINhTEbz9m/xEm7bG5AbQfyk4XxjbvWwSw59l+pVfOw=;
 b=4K0zFymoKehWYqUSumA8GJ3Wrjxp7PaLpi2haU4Lw7eXo9Kpb4it27ZznB4o6uGM8rJE
 0kPFESShCeKFWuIzgLdA7yGr7iFKOko9/JEPSRA61szTUG/ZLiN7a84kIvwFGX+Kwlva
 r8qu5jpsLtCJ3orIWCbhbvmONclTKQnmSeOX3IPNhxGigGnxDQCSNiPPnrnfcd/HLrVU
 3B/+NXFvfHClj45lRBjT/k5sgESivC7rnnl4BzIw+WUmxxrdXOPYgeVDsy/kwklEksal
 CZ6L5+LQtjrVp1ALEssNtEqe6YJjDpWaGg5HmBkVg0IwB1Sbve/+N+cSfoGLE6b1bqL5 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd9xyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 14:54:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LEcknC002042;
        Thu, 21 Sep 2023 14:54:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t8en68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 14:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUXV1iWZMEAU432EJl8yQeV7djEI3mj/f7xxj6sOf03q6c8hNG+do9rIA8Z64U8OOHt6n374c460iBlhpy39dkBu5c+YhcS2f1zBr1Wv90rOY0D5FhOy7/C2hKTQ5LqcbaDyh7t8QzrRFPAuyPqJ9AJsNO2JgSBneMu4yW4KJKpQGbjLGEQ6RhrfmTW8rgadCLv9TqK6yho7ICoIh2S3XDqXMKm8EclEs4DGRoa02mMqSwwyXRZhXHoLMwGVXDDL+t/F/8lbvyX/SR/Lip89w1mWzSZut2qdCz4PwoxO1b3qCY+aoUuq9KfpyV1Ngde9oP3DjGY8SrozDtoqrvKBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GINhTEbz9m/xEm7bG5AbQfyk4XxjbvWwSw59l+pVfOw=;
 b=XWDfrx3fn2OQIBoMTCBE1ZBB0YSPWJdYVSVmP19JxTya8Ta5bFJfHzqrDLfSjyggtzDuroiK0oFw4kkN4zQTpNEMHnsgOpP/oS1RW1GmA/VZdji77djxaQvdefMQvu6Y5kkxRtDDH45uMRWk2QeXglutIJCUvizP6cCh3IV7uTwb7PDmrX9gCaEnjo6P96I+faTzqo9fDgYQE73UBM+dMH6gC2dyn/C2LV3ghicOVME3vkFwNuHpLOXprY9kXtN8R3+1gmmQMkY+ET5muI1Or5bbYlNcE8I69cgUa3jIvprTr16FBXj3A4ErP1Cm5c1Apvf24SoOHpTL2ddYwi1RCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GINhTEbz9m/xEm7bG5AbQfyk4XxjbvWwSw59l+pVfOw=;
 b=m9mp69JLUrI2P1qsu7iJkMQ/BNE1evrAdTE2pNRLahTIkOtGU9XPhO0QG1xxjfmj9r+fu1Mhhp9su30T0fkdye+oXvmzqugQz25DQMWr1TG3jJHmVnl8nadS/HULcWmsY3NO96XrsRm9FDyIz7HIJ/ImIu1vGj+pWy2ZMOtCa7w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 14:54:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:54:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [ANNOUNCE] ktls-utils 0.10
Thread-Topic: [ANNOUNCE] ktls-utils 0.10
Thread-Index: AQHZ7JuH/Bi7bXRcVEOYCb7Nv0GInw==
Date:   Thu, 21 Sep 2023 14:54:31 +0000
Message-ID: <7FA3058E-7FF8-4EE7-8E28-3B0C041DED06@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7057:EE_
x-ms-office365-filtering-correlation-id: b23d6824-41db-4f6b-0c94-08dbbab2a9bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPT1A68KvPpWsY1s82vpSh/Q3gKvpHdP8DWNWR/rmc0iabg0eGWLLNCBQ+E4zpdzKKKkUp5JHHX2d6Ls/pypZD6O88y76rc3rfoqc8q2iQFWojmPI8O5iiYYmTEqNpWnoOL3wX4lmPmhaiROWXO6nw2PqM5vkunLi7jaw8ByV7geVOYqcYoDZuDs341wivEfsyr/PQmDbYFMoATSaSnfHSHvB31f5CYWAbN8c0qHJRL1o8hKzxSqH/ANRGZlVVEGnooIxdOtc4KQFSUgYtauJsXQ200ck6tUEIGs+l0Mf86fD9/z8TL7Rl5pKMk35H5tqRhbrLasPZALuiTqg5P+5WnieMjXu0GRxiasZUMXClc2x2LNNXgdBdTfK3B+1rzrbYteRg8egzmu5QYa3TDuL1pQzlWdvfimCtkTXC6G34gfxw0KoQ4TG3cCaVOApIgcGIZS4JTriZSHbJuL1QCWcwNxxwsdiVMWisD9Y92Ztws80wrpGueXh/VjT179/6qquv3LkRoGv77eNLyw+ENCekBq+mxW3z1wrTdX2DS8+qf56hlDAVa7+F/5B1zHL81PBblalpEOvZDdijbEd6H9mcC8MifD9wcR++d5uJGq53N/v1quWsSrIuNP508MZWbtnvMoR6yRVUP5tzFBOPXc3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(6486002)(6506007)(478600001)(71200400001)(5660300002)(26005)(966005)(4326008)(6512007)(2906002)(316002)(76116006)(66446008)(8676002)(64756008)(66476007)(66946007)(66556008)(6916009)(8936002)(41300700001)(91956017)(2616005)(558084003)(36756003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hY11ZAkWi4lzHgIEdIxGtvm7RZ9+rtKf2W8f2e7FTgnk40XCHPJLT8cRq0Bp?=
 =?us-ascii?Q?yF6WPI/K5RbvSY5gEoDA0vGaMRhs+LTdvGTEFN9bc3CkwFR+0kUtU6i60xgI?=
 =?us-ascii?Q?qDYTvu48OJiL9KgWMBd/3jVAaEkYlCVcMi+fJX9x8EqtfNtSnhXx3iazZMNc?=
 =?us-ascii?Q?iSn8CA+8llsjYUV7W6/bZT1i76nUDFicOh4acoydIEnM7SPNuLqpyf8/BG1U?=
 =?us-ascii?Q?/4P7xSH/D3YAU5WYD9e3awef5JfQvL16kf9OySiWth/Vn6EESJ2X55sZlMIU?=
 =?us-ascii?Q?GJJK3wyOocAGb0krLnhY7Poe/NTUfNcDjlFENsov+OqNTX89tLeXrtJQ9if1?=
 =?us-ascii?Q?GaEUYPB3+kdAKQmppepUb6Gr+O/ycCg5kqMVSLHM8zIvhiCMb+Rj05qDdPO8?=
 =?us-ascii?Q?tsW19oCu+9fJfSRxXXdhjkyvvYk1tV2kRYk0DCP2rN+tWhsgc2Sf+4j1+Vvc?=
 =?us-ascii?Q?JbTr/bTW+PoggGMutKX6zmwqsx+bOXxJ/UQ3F74fpQZQM2xs8wZXUiWvpPLd?=
 =?us-ascii?Q?WqLPxed69xyKHyyl5L+CJJ6tGJf6IpS3sLKHM54kju+sGLSxIOfAZ+qhVq16?=
 =?us-ascii?Q?vxrXlcUY7vzUXlbIGtOZhNFGq02y258PL8dkja8G3lxncz1Ic6Qz1G9F4j53?=
 =?us-ascii?Q?nXYvl6TU/k8tk33XY5AvrGmjKyqUpaK9qEYwdtCCaEYX/eJUzdnC39YmvYXx?=
 =?us-ascii?Q?KR58W3cl8x4fsGthNLBEvriKXBZG3oqTwC9eT9nO9BXIIamVjHSEo1WZmIzV?=
 =?us-ascii?Q?vOh1IlOanbtoknEOWbt1LuoKpmdJsGLt1pe2dhoJe75oy8IIwrIk5adPp6w8?=
 =?us-ascii?Q?kCDMLhFmdWK2lzySwpUG0cqtjubLGVdcI4KHhDsb6wvdpL9apYlP+ybzdW0e?=
 =?us-ascii?Q?lP87hwrH6nY+tEae6FX9MY3XLV/iaDc4XyrqLFjhzF++IvKaIpT4hFh/TV8A?=
 =?us-ascii?Q?ZfFDcnkVwPbw9AGwG0+qfvZSVdiJdh03vl/avhDGj3l/+48ykYa0hw2Mgft6?=
 =?us-ascii?Q?nszUBm/SnFIKUd263fQw3MtNL/oRNV0UWXgzyW7mXoQAEN2u0o/GzEGUeyjt?=
 =?us-ascii?Q?zqL/lE4CdejZx5DO/qNxHwQudmKYOGlllv9Z4cDcNNAfk6+dcxnKLmTSvkRq?=
 =?us-ascii?Q?YG6Mg8JTjCY15qfY7oTInLVxWAzkE6zGjuzbYPJVMRJMNm+LNm8GNDBEy6HV?=
 =?us-ascii?Q?/ns0bkFgSjK/lnUZX9HAAp7VisFYAEQ+qBbyqpBFMqDzAtOy1rbJPkrm2/K8?=
 =?us-ascii?Q?4N+QtdXqtFAODGZcbuDfmQEp8pq8wXrgq/vgZumww9zVhJ2BeFWruBna++N0?=
 =?us-ascii?Q?Kvb5UAfoCLEspKc0yLeKC5wV6qcAkIdhOriHORh2v73W5AZWByoj+7oAMAu3?=
 =?us-ascii?Q?uJM+ziz7OqyAwFz69VVStLlFD2jEKDBCDs1U2sYlRRkjRaTg0zhaXrnNPMRI?=
 =?us-ascii?Q?WlNQC6G3qb0ywJwl6fc28dHhmPR06oO7V+RxnWVzUbr7Zbpq+nr5jS+Qy5BJ?=
 =?us-ascii?Q?jhQwaR6rVgMA+0vGFTy+aK2kDsMfraKYwG0LTPp0ppOynKzx2yumOWwqBEHA?=
 =?us-ascii?Q?as2KzdkejSOXpxGhl5vbD/K78BddD1S7fqWnf055MDaskjSIwNDxR2w5i+vy?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32194A8C3910E44CA4A0A6CF8FD3E813@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D3fmyG3JX+PigsXceE9JvRAIXxJBpojBKkSkwFu/Qbn891E+Qh3redZVdY065vqswztWu20ZWg5tn1SamDclayrqNJBfrWec0opGzhW6dzzcTg90hkhPxKz+Ghr9oNjaEs8VhfAJPsMaev5d1QGtjcoDD4vcraIbxMREZrGBhBm1cqx6LOyJJj3VzlxN+ND2zH/lX6YTQg9kz5/9GnPx4Bvd34KShhatXibawXKbLTW2ziAra3MPaWk/CCvOwCVPzWZNiJ2xsCZ63/mqdCoSkssRmbBRbT3DE12HIXirsDRa4gm7C9zfv7qnJexOzklU7iBWl2zCgVD9wvxuq3KD5/CS6lnV4pbSqbnDfXLshV2sgb9DO6UfC+LsqyltA/Lc+wxNgLBAdG4/ZNpZ7qov/WM9jaeg9idF69vNhTFGcwn0Z1U5uesg4EwLkkrSaE2ulHO22RSli0CFkmCFvlJ1hJ3Fss5+Kl1znRGDJAgD1jys5BovmYO3vRM4bnMc8YUEbluN1SNzuJLBujl7uwMICExXLw4hYgPD/WMk/29eidENodzmjgMfyg5RmpzflmNPUX8J2AE6XqnsVgoil1dvPK9Pwv7shafN1drejeMGRu9+5ZbbkVhZaHqndxvuwkkhyFfWjSo43OrEaGncvqJP/PjCZWkGYg+k4esnSVF6y5rXmYOnvJDCZ6KC6rHRrWnv/QNRHu+a936EuHzuixxkYAAZ1t5WrDb6CA2dWa+yvmjZTwvWc38Ei/Ls8ia+LmctCTy6KRKHhFi4/SuT+xPVj/AbGoQyMQvw2x1Ej6oNaOFcq92ArK4fPaRCHo2v9vxy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23d6824-41db-4f6b-0c94-08dbbab2a9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:54:31.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnJ4H9IWPOrK8a3hV1gKfjH4Pj+m1CvwpP3tLTxt9l5vJi/KuyB4ImN+u1AMJDn/hrEGwnsGCyadcALXTZC/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=793
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210128
X-Proofpoint-GUID: IcI0y47OlJfGBEuG-YKcdCW7f87d6JTs
X-Proofpoint-ORIG-GUID: IcI0y47OlJfGBEuG-YKcdCW7f87d6JTs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A new release of ktls-utils is available at https://github.com/oracle/ktls-=
utils

--
Chuck Lever


