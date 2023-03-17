Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4496BF0C0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCQScv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQScu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 14:32:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9D4D28F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 11:32:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HI4LRj021622;
        Fri, 17 Mar 2023 18:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o2Vqx8iThfoafYHZnb3knSsTbg9KGR9H2j1hpP/aFzY=;
 b=efyYC3u6mOZ0Sjh+qLVLzSzhnOIAuGvaHsLJqsnScLHlNnDwGS83zngMksdUgIh1Y+xC
 268MTwgOblfB3MQIDgMv6EApyzJKo6rAZV8OoP84IAl5oLPmhgNdyXgSkxWCGzmK8PX8
 dE07j2uQ4iQrkccDz7EjHAFciuUpIMOYdMd78QIgWHvPT0zaUoY8Ri7IYnvPfJlLmA2c
 Hs3duRO/w6u7EbBHfVBWABI82qO5ik7X9DqLD6lXg9hLtzcLoVvJbCcmki7kNIYTwf1q
 276tPtOGAohtf8us1E2CbDxJr+iR1b3gmJI94WXoQReNSgn7Jfts7t/3BVXcaCO0bWSN hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs294emm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:32:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHHHjc002493;
        Fri, 17 Mar 2023 18:32:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq4854me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 18:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ8rq8vQTI5ezh3OQjwMCCe6BZw7qg5IACGIAxlBg4VwLnyag7Xu7xOYE7Qpd8FejT+ZO9ujq/rvp225iCVSiaOzUFKQRT55rqgNtVg9frK2lgTZcKR0kzryXJJ/bi6kZtJwBpiLukNL/Prd5JJArp/fGs3P9Xct5IPeKFouHTB9IhypMomyIg/6hk5Rr4k/B8NdLLsd+ApyhChcrdA/GrjTg69z60H+mN0Q+PfCCbJzjj7D4MdhlkwP6Fznc3HvqZF0FlUk2lCO7cZVuVzwDbS0y04SLWlNTTa3C8Gf/y25Z77aZYjkC5LNE3du8sB/edCdvtvHtrrwgwY1vkjrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2Vqx8iThfoafYHZnb3knSsTbg9KGR9H2j1hpP/aFzY=;
 b=F2TrsQIentsy7+2DwtUjFD+fm66eaE8hE9MJaPZpn/CccANDqtw1xIL0ypkGCRvn+ou0XNQuz5ONcOIh3YUnfbMDNNXpXc4HQ0BEzu6qVKfK+PAvhxn4ojPyhr1R9keOCWoX7Uc/1eUkrPR5KE83ZNwWs5041SZgJnQ830WTQ+alHbccZgAh0J1C+hDzGgmqJ+QmG5GPPXZwP/uddTWDKBg3qkE+xV7rPLoNgl0hmMAydNJtrpMNIzProjGIoaP5kXDwRGvbGpXnavn/9fy3kr43Htzps3Xk5gS83usyam0lZ//LtiX+04M8GKE6G1UVVMNvjPyUtM8F+5mtyTCAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Vqx8iThfoafYHZnb3knSsTbg9KGR9H2j1hpP/aFzY=;
 b=wvxfpnkeRp7KoGVj98Jhh6eqiF/1hE7hD27jaHIClVwMdtA8oVTpn4gsjndpdu4oelpuXuu7F02i2HREXJPpnoz4SNO4j1JJVBnowL5lwFJAprXXni+624E2KIUrHaB/DwguHH6TMus/wm4Asn/Dl/Ep4j5gtMlfTUF25HuWK6k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 18:32:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:32:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Topic: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Index: AQHZWPPHhxprfvZio0CVZD7mRL0pxa7/S8kA
Date:   Fri, 17 Mar 2023 18:32:37 +0000
Message-ID: <D67DF2B8-75E1-4468-B264-139A21F1032F@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
 <20230317171309.73607-2-jlayton@kernel.org>
In-Reply-To: <20230317171309.73607-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5822:EE_
x-ms-office365-filtering-correlation-id: 3569c223-0f08-4473-2b12-08db2715fbce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dj95WKOoqyrNBo6p5zDvK9vWD1B3QGGyOgbjB9NN+K5VxOfujmcgWHZph74zJaTKdM00mI/nYFKX43ck82G9MDdfhNLnpMB579y/trBkqNAJ+r+cNNWK7P7CQFgFIf5G+ywMwfW5bOHczWJgpOVj5ti01XD0ookGvLzQgDNjMg6qI0suMAn5QQvhb5FQxpFzcUnL+b/BqLYLQNlWvwjAa8RTLwWfDAA7EXK95GCcpvrqI6x/Ce1CG8oyUV4TJl/wKX1ZV0Ipmj7kaar1JBMPwhpBeMc2qSKNxsxSlcN3SQJ1yAJNUpq/+MtqNKBMP2enz4XpXXO3xi6/XnZpfU8dyJ6ykZJ0CSpXGBARUETmGjvwCQ2lh+TpAMVLczoxROyVSi/ktPUyCAt3U2HCg5AZrGTCNnu0FUBl+/Hp2xV9MnWKO7/mNw5L+T0MNb12fZUwLES3RZyJ4KFOt+SX9Lw95kfDYHn5+Ys9nxIE8NBmgDwXXGuCh4uOMxf1yHPoZXnWVbDhzVJ7COn7b5Kfcf6Xwe+WwmkMhi/sAa0nvAHeosQPnWjU0pRAymxT45WbYBcLa+l+wKVIhIUJiz9kM2m7lhBK6HrwgTWQ9qAzeso9gfYz2ZiVcC1JYldNChCSkmCM/uBkGJpaC3JvF76DvVCqtPXfm3iu0KSYHglV50fLAp3yFmqYuQWoP0Litd9ADP/roro0tB06zD5zu7603F33HiO5MlH/ldkopZyY3GmF1EI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(41300700001)(8676002)(76116006)(54906003)(91956017)(8936002)(64756008)(38100700002)(66446008)(66476007)(66946007)(6916009)(4326008)(66556008)(5660300002)(38070700005)(122000001)(33656002)(36756003)(86362001)(478600001)(186003)(26005)(71200400001)(53546011)(6512007)(6486002)(83380400001)(316002)(2906002)(6506007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LhAvyHBn0DTlqS0HYpChURiuR8ojGYSAPPUt+xtJ37/NsGfF9OFJ/TbTdVy5?=
 =?us-ascii?Q?ERIcNyXrf9T3gxenCv1pJ8ABtzbmFm2cxlXtPxtZuP4I/rCf5VAsdpxj8atL?=
 =?us-ascii?Q?vPHlwZoyB47WStQK+4qDXTukBR48mFFpKgivb3fdAgTwNnFbn2WWRUakvBBU?=
 =?us-ascii?Q?Zc2kWV6hsQvzgD0pZU7R+IeEBbKp24Eu8Qcoo/42izDoJHzE+M57urNSeDPB?=
 =?us-ascii?Q?5a6C8R/tNxVG/MNk82IcXomVAVTqFNGRqcd8XDUjFTPMmaE8TwsjsXaw5s5s?=
 =?us-ascii?Q?D0XLEZS4oQOENhmNwVmJ++9vmITbeMh5Xky5DsePvczyMG2bR5X/uvQiWCK4?=
 =?us-ascii?Q?/VpK52nueSpJj9WJMY8W8Ui4BSYSa3iED0h0YLU6k4sn8VepMgld6sS/lcc8?=
 =?us-ascii?Q?qbtJ4nRKI7PLYbxBh/dqNx9XlNx/ee7W9BuG39gAR9KBqagmRLUDpdudiVC0?=
 =?us-ascii?Q?pvA+jHqMwc1Lch9nLZH8oQpgiqbPgGf6xdYLU0BIo6wWG3Bj87UNj5aTRL9B?=
 =?us-ascii?Q?fQeFCsoMpxtAt4QLFbqAzI82u8avs7vcklr5ZHYtS2R+31beGN800UdYaXG+?=
 =?us-ascii?Q?7Y7bLlRjP8SNSOHMZ2kzTdHcZtRQy+jRgPDJEnl4mekT9r9Zbd4PwPZvCSZZ?=
 =?us-ascii?Q?El5h9CLAQkg3HbRRWfB7BV/TeZqtn+AqRAig2QIq+QLzxwOzZETwHOKxuBJQ?=
 =?us-ascii?Q?AuA1JRWP/DI9JL1BkPk8/L75f24dblASQ4gvnP7PBXY2gDYaljWyVqjpv6AN?=
 =?us-ascii?Q?wo61LDcaRo2kkGQ/eWHRQb9C70EHiFwhJFEEmIuourLbhFQJfM+1hPr7D6Nj?=
 =?us-ascii?Q?zikdx6m2IfJy3hAA75h3hG4RBT0hF05WLMrqXoY535o1YqE/U45GN8iIOkQK?=
 =?us-ascii?Q?L7XYxx2rIZzxwiAfsREClJjdntwbvUbbGDpPA6TvjjHurlbfUMJf3NSR6H7t?=
 =?us-ascii?Q?vDicWU5M6oih5XIUKJ3HxjKqIwDd4at74G4lLoC3157f3tG5fNouIjRJG6XA?=
 =?us-ascii?Q?givTWyG/0PGf4UBsMlCc2x/IMA2HUVABYXpKDiBuj2yl0fh+zq1iUC9mBFlJ?=
 =?us-ascii?Q?wx1fpwPvg39gYlC1ukHYQMdYRcjDGOqZH7DMClkyI1gehCk5PZ++8CezUbGj?=
 =?us-ascii?Q?l2+DZQL2OFrm+ShAXQiadteFbq1t0gCgksqtbuw2hdmwgvaNXc/cpCuF/pSc?=
 =?us-ascii?Q?gOJbdYVnyCDWY/6z+xoNToVQDkJLVY26S0yIq7m63xDGnN0JcUYG2XZGzcya?=
 =?us-ascii?Q?EcV0LZ52gRfvk72H8us0qjCILncIxfSLe/skzZJKLGT6g2elAdsB8Ga0Ty1E?=
 =?us-ascii?Q?ReK2RBslUgxc0QOsGUIY/F2RdzyGqnXoTKJVmMk8edvZraB341De/zCo9/o+?=
 =?us-ascii?Q?QfuBA1eOQA7zpa9iFjW+GeHjdoSays+Tl8qa4LFoP5VKSwJCr8b3z98Ax9wo?=
 =?us-ascii?Q?S3JlfOCO8Tf4ue5TAvzWBVUBCq9ZSww3KHbk10fcYxuzMEhq7Da61RJpc+Go?=
 =?us-ascii?Q?e7TiLXeGdpNIIphjN0/qS6MqtYcoxN+Qwh4rL+Lz8wfaVFceJ3390d4DBT8d?=
 =?us-ascii?Q?DSf8tfmBHV7JJyGOijmGpKaJ7A0VMfbIOVv2A82Oybjr8WL7BS5gRJ9BX+nj?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A5BDDD959EB76419E4FE08EC3ECA6D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mgg7cTs2kQ1B7OkRQioNpybSegZlnxYX6Ptlr+Uun9tYCa3xACw2HZhVly69bbap3SVzXV+tC5IY++xcOd/kp+sJoApqjuWdUZJBgTPFp29EL4wM9ryHqgEbO5KnuBlmST5So8P9lUMfxQMuhyNDR1tnDAoSQJd+8X+4BVcrQhcvAoO9bN8EzgCvhae4EGUIkbZj75QrpVqxDXS0iS0tNhDACg4RjZrn/bpiXNwx8xIzWr+J6xRELCh0fndzGeJFJ6qT6kH6evD1n3ll30yzh+6UrJNVGFzryG0Eox4vBU6zgxOqwO7me7iXh92iw15sL/fcWQL0TO9tAuhxX06oMflX7u1d5d7xw8sr6lVeO3axnL14i3pDbyNhyE/kYB6kYDKckteguGhAslrjfh9Z3Nb07B8zGPNYR+XPqtkWjMgvOxj0gXVCu4LtnZ4A+rqsYWfKKZotZBI/InNZjZMtRwHTdN/pluISKaS4rHwsVIfQwWJsXMK5T6/33iUPCEWvqFius8L/WrXhVdejrxFOp1G2gMwt9Tt45/Csg1jDwf7Wy/mYRcpk5661ECxBdSsHZ0Lo6pHjjxLzRtLzZLsoyrPOCzDtFS392QjkgfqfFKKjaINU2KZ28NgLARnEkyYS0cOPxw6Jf9Bk3dTGF6tnqFLROGm1g2yIEDRthvnMBiR3NUt3HWH5akIZ6QJefCC5FxtLFGcGeWsx1bPTNkdZUZ4ZkySuk9uQrk4r+SRWGOdit4NosHjnkdhk7cVYwo1iPReEnmq8iRHAHuQP4M+5H2WDBO5YyFGx8UPJZ65X6V1SXUrq41hsqEYP997vAZZB4qPSZnfIMQhwCS2BPks5k4c5rE/00edr/owVVE09mMFFYvhCzjxGi6DAjjoEgf107kznG1r0vIIJk6plsmmsGg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3569c223-0f08-4473-2b12-08db2715fbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 18:32:37.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5O44JjvZVnMCRYLRrL/avN+0r1rmL3gODJFC+kTb73jhSvco2lcCBKZMiaBedDbJfEUENeQ+SzKIEPLRotJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170126
X-Proofpoint-ORIG-GUID: 2FXSXBiXKDPBx_58qdmEPI3KQLipdOm5
X-Proofpoint-GUID: 2FXSXBiXKDPBx_58qdmEPI3KQLipdOm5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If rq_next_page ends up pointing outside the array, then we can corrupt
> memory when we go to change its value. Ensure that it hasn't strayed
> outside the array, and have svc_rqst_replace_page return -EIO without
> changing anything if it has.
>=20
> Fix up nfsd_splice_actor (the only caller) to handle this case by either
> returning an error or a short splice when this happens.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/vfs.c              | 23 +++++++++++++++++------
> include/linux/sunrpc/svc.h |  2 +-
> net/sunrpc/svc.c           | 14 +++++++++++++-
> 3 files changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 97b38b47c563..0ebd7a65a9f0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf,
> 	struct page *page =3D buf->page;	// may be a compound one
> 	unsigned offset =3D buf->offset;
> 	struct page *last_page;
> +	int ret =3D 0, consumed =3D 0;
>=20
> 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> 	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> @@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
> 		 * Skip page replacement when extending the contents
> 		 * of the current page.
> 		 */
> -		if (page !=3D *(rqstp->rq_next_page - 1))
> -			svc_rqst_replace_page(rqstp, page);
> +		if (page !=3D *(rqstp->rq_next_page - 1)) {
> +			ret =3D svc_rqst_replace_page(rqstp, page);
> +			if (ret)
> +				break;
> +		}
> +		consumed +=3D min_t(int,
> +				  PAGE_SIZE - offset_in_page(offset),
> +				  sd->len - consumed);
> +		offset =3D 0;
> 	}
> -	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> -		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> -	rqstp->rq_res.page_len +=3D sd->len;
> -	return sd->len;
> +	if (consumed) {
> +		if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> +			rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> +		rqstp->rq_res.page_len +=3D consumed;
> +		return consumed;
> +	}
> +	return ret;
> }
>=20
> static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 877891536c2f..9ea52f143f49 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program *, uns=
igned int,
> 			    int (*threadfn)(void *data));
> struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
> 					struct svc_pool *pool, int node);
> -void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> +int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> 					 struct page *page);
> void		   svc_rqst_free(struct svc_rqst *);
> void		   svc_exit_thread(struct svc_rqst *);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index fea7ce8fba14..d624c02f09be 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>  * When replacing a page in rq_pages, batch the release of the
>  * replaced pages to avoid hammering the page allocator.
>  */
> -void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> +int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> {
> +	struct page **begin, **end;
> +
> +	/*
> +	 * Bounds check: make sure rq_next_page points into the rq_respages
> +	 * part of the array.
> +	 */
> +	begin =3D rqstp->rq_pages;
> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];

Would it make sense to use rq_page_end here? Just a thought.


> +	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp->rq_next_page > e=
nd))
> +		return -EIO;
> +
> 	if (*rqstp->rq_next_page) {
> 		if (!pagevec_space(&rqstp->rq_pvec))
> 			__pagevec_release(&rqstp->rq_pvec);
> @@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, st=
ruct page *page)
>=20
> 	get_page(page);
> 	*(rqstp->rq_next_page++) =3D page;
> +	return 0;
> }
> EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
>=20
> --=20
> 2.39.2
>=20

--
Chuck Lever


