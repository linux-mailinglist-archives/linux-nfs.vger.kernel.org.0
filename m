Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB46873D1ED
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jun 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFYQB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Jun 2023 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFYQB6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Jun 2023 12:01:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EEF3;
        Sun, 25 Jun 2023 09:01:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35PBs0Ms015610;
        Sun, 25 Jun 2023 16:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xgn9roe6jNz0CUUn5QuVWFx2JdASE6q+yJC0ALzAQho=;
 b=LDo66syXWuDotqH+6sdsdyFCJH7EGWsHUuwf1+po2hfVrV6L+X2P/C1JitRjL2mnRaRm
 D1zCgUKcRAlevYro8ZYymr76asofTsJYIw4xTsqYgtXQAcXsWqWDYq2rvLaoJWlKBDWa
 N+8st7sdsNvzrJQf2Ik9XZQ3JofL1VyIR4ZmyMmn0ecfaL3mIEhCGs0/3hkj316ixmpV
 a+6qOPCk+UbqXOjNmUiA2RMAYe+u/X4P4WbV3mn6ney+zhBX+fJCOur1Ilhznga4fE9J
 /cZPuJUQuG/ArNAMiVPfotml1Pzx8qZqbbZ8dXafFCn7ArwkYevrHpFWr5H78RBe+CF3 eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca18k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 16:01:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35PBRxHI018852;
        Sun, 25 Jun 2023 16:01:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx2epwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 16:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx8qIGiupv+mVzc+WJiG5gsM5O3H/7usjIWw1BVV4mlww0EdDw0vjgA2CcH9HFOvFySp96j6Jc6s654cIIdt3qNy6c3VP5gT7rwAwWETfZEgUnFQrrpZHGuS0glYbNj+k9gzUyKFwfYYoMFM1H7W5K//PTUqW1D9M5P9UKvs4wifNx55unmD0J5W+2tl139haMezelAPmVM8535AeRbsJyIZlOSFeQH55G0yr2jKYocQLfCc3Lj/8NlJWVD2zydHDRfJZyIK8ybWeiRWwlg5SOCbOFon2w9l/SNnjVyb0YYxNezbUSG+HV+LPaRA2dbLEGt/ka2CYGGd9KTOTk7GTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgn9roe6jNz0CUUn5QuVWFx2JdASE6q+yJC0ALzAQho=;
 b=Wutzx0PXazQPaFdkLi/02yE8Kqlu4d245cj2i3gryQznzME/2XQWXr7bzFx3SyR0ME6LQvj6yae6VWITz8b5qCA2+p3P/ziAogFryOZ6FX1bb4NiW2a+Q/Sn8ervg2kNXHb0csb7f4c6B72GANZDHhLkZLj53fPySlo66fmszDytcfgtt9FNH7DwY+7TE0hnVjJq/duxDkh8NWpxkh5PBv7vu6aAcxQIQ5BwNN0Czv+dbebX19VczTK9DB63YJMZ2Y1+OEIPtdaPjV7zFeby1GgoYzu1psyw9KkHIv7JZ2dMbNpUdMV2A2ZDVFyq0+3hWAqjl7yknoe4V2zf0U1FgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgn9roe6jNz0CUUn5QuVWFx2JdASE6q+yJC0ALzAQho=;
 b=q7ogPgKk97aHKGLEdXb0fHzaunpxWCqN6hMRGBIenvv0OrJ7ojsOHdXUxnniyQGVascg3HCKsx4BYZwG3tAXh1opeuMrs0mUeepiBSZaQ7Xu6EF5X46HZWcFBPoNFHd6UIV1wl+DhvX/fG5xWwJ96hek4tWaOgOrrHjKEHK4ySI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 16:01:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 16:01:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS9Q4z69UfUdkyWw4ptMMUQRK+VxgUAgAEyXACAAD0DAIAABE6AgAE+A4CAALplgIACgdYA
Date:   Sun, 25 Jun 2023 16:01:38 +0000
Message-ID: <24E8E2D2-F91B-47F6-91BF-02D02750054F@oracle.com>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
 <ZJSfsvFtC_d265M1@slm.duckdns.org>
 <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
 <7E9EF026-EF8B-4125-AB00-A1E9F0F907C5@oracle.com>
 <ZJZKb4CvyKmHBwmg@slm.duckdns.org>
In-Reply-To: <ZJZKb4CvyKmHBwmg@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4147:EE_
x-ms-office365-filtering-correlation-id: 576b75e7-629f-42ef-ab28-08db759575b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYpg7GYkien1uUe6P7ZGAaXjHIIaB1jElaSsp0FOegZ90Je67nvqxUHcOk2wmsfrignjfBRTdVCyInubBASPTTDffxjZtfgB1PJ767XyzLa4LvQsbJ3Pv4wWKLFYfDMoSqcoF7rdsHWMnkmwclaGlZpj88IV0WT4gy7JYBkceTnCXEWaBQE6gTbSHCLWFEXOaf8F/tf5djP8B7CmEUfcyRy9qUZtijhCx4kY7NbpH0ypK8pV5Frf5RKO6H3DoDsb3SBjHvee8Q6ilJD9DRR/XG/55WL450EWXng6/ZqHOPBj8AHGhXLkzlDKsKnPgoCMFa9ICkIJV36U9HjhmtB39evsMU2Fm2AJ9r3bUOAysxrSHCEBy1f8NNhE5Lzjytu1IohTqxh1cr+dkTiPY8il02g/ceJPhLhp2fmmfVEzEqdGI4UJJo09hegIlKC5BlLngzX4gWSvq1swH+wYpH4UBky8v99X8bj0sxmIdtJhR6MYEtTd4icCSGc9evvNSYg2N9R6vocgqsLw1Cq2/QJGXtEzlwFD6OtckzVKN/bG6IltB8a1xu+sXTcKz31ViccV7OZNDpMMZP7PSwMRohCvJu20tNZ5UcsT41hrYhkdgvmYu9B2h+seXyOZqmkwvXA6TzjFbPJLbuJT0txsRrSd4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(36756003)(33656002)(5660300002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66446008)(38070700005)(64756008)(66556008)(76116006)(91956017)(4326008)(38100700002)(122000001)(66946007)(6486002)(6512007)(26005)(6506007)(53546011)(2906002)(186003)(71200400001)(478600001)(2616005)(54906003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WMJIYTl5VD5ZCjthIfZIc7FAW5l1wuTtI8eAKvie6L0AFetrUOZB8pU9ahmE?=
 =?us-ascii?Q?OP5HOX5RAH6p/mPxwssEAH3733qZzTipvh83N7lTFqZiOYnBarTpBjraQmNS?=
 =?us-ascii?Q?S/WqxYKf58PX7SJrkrCMLbTeef3GkS5pzM9CvWUYNngOnbhkmQvwW0AqNecn?=
 =?us-ascii?Q?MSUT4h74/zeEHuGCEZMsS2F6gqL+PhI3bWGz9R+M7Ltsr2S6SwzR94vFM0fz?=
 =?us-ascii?Q?2o+nI79sOPjLUsKu5t9vm3Nz1FCuIMtDdpSJ/2jgslzpj3uXveNxwMuM4pxT?=
 =?us-ascii?Q?6Lpa8GMLznJmOhvOmtvgclUCPVBY9sZ0CslM9gHgvlJfVI0vV5IAi+RRKm0E?=
 =?us-ascii?Q?7x0i5o4uBo/8nVJXU+4xT5zUQawT1QoVGLFYMFhCs/70wklcKh5GHhW0tNLW?=
 =?us-ascii?Q?JsOEiQe4gG38gSaa7ASDihIKcM1I5nLwMteByZGGqf08sRpBYUZl73CA+xLK?=
 =?us-ascii?Q?rY+WXq1YbWQPopsF8MVeJnUc7Z/aOqySO5iZhznXpe7u4wD3PO17pK4+opR7?=
 =?us-ascii?Q?scTt+mI/wTJGMwWCXfetNwMW8I1BuLi6/3IAl+DD4SHSfONyW6TZF/m7dJ8m?=
 =?us-ascii?Q?XB5RpwA06e9qLz+sKIdggHzkFDzgCaSHC/95su1AQdmIPCwt+fmb79WRLSqb?=
 =?us-ascii?Q?h93Hj+LPkISt0CDj9RDlCfRjf9pbdZpqIDsHvvvoV66CV79K9P0llDiNIyaY?=
 =?us-ascii?Q?p37I+AMJl95Yk6l4ijcNCqOZq1TXiJroMuCoeISO78FGsjmX0zp0DRUIsNgP?=
 =?us-ascii?Q?3QVzXkfMnL8gmhwrV07QzTGuybk+qSGiCzu1q2BpDbKkjneBr0A/EisAVfXG?=
 =?us-ascii?Q?4q3xLS7M/t0Bxo5h21DETCfT7i8vuaVWHwoAN23dCH20khkLixaOUWkajJ1i?=
 =?us-ascii?Q?8SA/1xPVD+bPJraf/NdX+LEEjtM+pICQd5Ag1mFjJUPD2Bx5D5NouRBN8qfK?=
 =?us-ascii?Q?2fEUpjQP24dbntjOZcxmhmQ/8CAV42V719RLbxDwmMMqWQOM0BXfW5ys00Ie?=
 =?us-ascii?Q?CPrzcXLeTSe7Vkx3NXu/4S0W5YZj+IwMhk5pbSngde9xKoDWlcabhUgJtB0h?=
 =?us-ascii?Q?NpbIDiIoTa9eBzy74sefmTDt3ZrFaWdzXz+33gzYZAPpHczdOZgqYY+XS1D+?=
 =?us-ascii?Q?SQtCyT6gavysU1tgmwUECH2Gfo4ONFj3b0IdJ8cnw9rS4Cag5GGI7AZkT8TP?=
 =?us-ascii?Q?eJXcTwI/q+8P7CgCy3N7Ih8+gTGrqS+moPMNC0U3bZTageZlKbi8LqBOx445?=
 =?us-ascii?Q?0bjzwoN1BztbLZSI8LUPNruQ31No58f+Fx1z+lLJNsHWZiP/Gl4dm5BSYR/7?=
 =?us-ascii?Q?blaLYtUQmeMZa/iVUwe3QqCJbN/3W3eLEJEltbID8rRaKadbcJUUl8MkSBGF?=
 =?us-ascii?Q?FBYgYZ3PDTnuIMw3wc/clmkeWI84HH4Y2utPFXQXJVdRQG/mblq0Pmu/wO3R?=
 =?us-ascii?Q?GVR7wt/5dndudYfaW5WhR4CUk7H23jgzf3MGR7BCTCP1R1j/Z7NUGrXoqayj?=
 =?us-ascii?Q?INL60P8v3lcHuZeZrXqutNiTib8ZNspZ0UGHI6MAgzfidE8FPVnSIhtrXUOx?=
 =?us-ascii?Q?3zQxmtIJ2mEw/yq3dFaVL2DR1TyqKPiHsGw3o4tYslH+GNdtw/moo1Ps0ZoO?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <648CC44CAC35C44FA0AD10BDD503CB7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nGrjwZtFSBFXF9/0yfTfM4grqvYwtB3BMAlETOCSq59bLwEmlwQjPBpi6Gn8c713EkqCQm27eRp6TeaA8dU+ba5lzFrMF01MALATicrRLByJGv3Qs/bmvGiTtSTic27ltxeobUh/eheoc3lFayJspKXOtlNeRs3YWlbbMWiVLrYZDzwWY9sZoJbGLn3Rw7wQ9xAy29quP3UOqMMvl9zFLUw7dtOxM/vZTx4QkbwWjN7isjfikdgmTdQ9YHv8BpvgGtouS21+2Vvsi9VRf3KnURUXGRlMYSL1eJXLa41hykiH+i7uocBhxvnKxqls4xjP2/lCXM3n8EfGmMUUFmug8hi3pwh/9IDE+GB1gTcUH8vT88UL4+eY5k/dXZNKfg8Y+3MvfQqUxUY4Kcgy4w5kXgfQxjr7dDUpjHg+j2a07gxCtctL5dnU2b5DFgrWuwfrmOPw8ImT37gDvnVCvP61OA7Uj2D0hU/Hi6BjhJb+IXB/C7d8cH/9tdh20Dg5DBFZ8ZUGyfMIG7n1FbHexMeboYdTUO+xmrmPpWloue6hv30W+/zjYjG+9bc55CJ3u63xPOJpfPgW+i1kb2Ip9TbR2Ab9qQrE39kSbvGR3PmRwfkY/Uspv0NaGblvt31mnofXYutNhAs4rGjNcfjRwwSTUZFrt40IHpEe05cDWuf9ifuWC7AeDO36PJJ0ib284o2j3vwrX/ZwJWS/6v4rnMKp0bqGz0EX6HSNB9xwm3GzOUDEo9eAmGRsDXdvJ+iUCWEmA1R4uIEslE43Nr+7AFkwj1kdLm5wQqqXYMbL6cdhDV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b75e7-629f-42ef-ab28-08db759575b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 16:01:38.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRd4U8a7LcV2s1Ws1eXqrLx6XDBRV1g205h4J/+YzgIL9BjJiErA6vIcZcth9P29P2jegoT7zRcM9uSJhLmjWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-25_09,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306250153
X-Proofpoint-ORIG-GUID: DsXC6oXT34mtXuYIpNkDtjRdXvMg_y9f
X-Proofpoint-GUID: DsXC6oXT34mtXuYIpNkDtjRdXvMg_y9f
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tejun-


> On Jun 23, 2023, at 9:44 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Hey,
>=20
> On Fri, Jun 23, 2023 at 02:37:17PM +0000, Chuck Lever III wrote:
>> I'm using NFS/RDMA for my test because I can drive more IOPS with it.
>>=20
>> I've found that setting the nfsiod and rpciod workqueues to "cpu"
>> scope provide the best benefit for this workload. Changing the
>> xprtiod workqueue to "cpu" had no discernible effect.
>>=20
>> This tracks with the number of queue_work calls for each of these
>> WQs. 59% of queue_work calls during the test are for the rpciod
>> WQ, 21% are for nfsiod, and 2% is for xprtiod.
>>=20
>> The same test with TCP (using IP-over-IB on the same physical network)
>> shows no improvement on any test. That suggests there is a bottleneck
>> somewhere else, when using TCP, that limits its throughput.
>=20
> Yeah, you can make the necessary workqueues to default to CPU or SMT scop=
e
> using apply_workqueue_attrs(). The interface a bit cumbersome and we
> probably wanna add convenience helpers to switch e.g. affinity scopes but
> it's still just several lines of code.

6037 static ssize_t wq_affn_scope_store(struct device *dev,
6038                                    struct device_attribute *attr,
6039                                    const char *buf, size_t count)
6040 {
6041         struct workqueue_struct *wq =3D dev_to_wq(dev);
6042         struct workqueue_attrs *attrs;
6043         int affn, ret =3D -ENOMEM;
6044
6045         affn =3D parse_affn_scope(buf);
6046         if (affn < 0)
6047                 return affn;
6048
6049         apply_wqattrs_lock();             <<< takes &wq_pool_mutex
6050         attrs =3D wq_sysfs_prep_attrs(wq);  <<< copies the wq_attrs
6051         if (attrs) {
6052                 attrs->affn_scope =3D affn;
6053                 ret =3D apply_workqueue_attrs_locked(wq, attrs);
6054         }
6055         apply_wqattrs_unlock();
6056         free_workqueue_attrs(attrs);
6057         return ret ?: count;
6058 }  =20

Both wq_pool_mutex and copy_workqueue_attrs() are static, so having
only apply_workqueue_attrs() is not yet enough to carry this off
in workqueue consumers such as sunrpc.ko.

It looks like padata_setup_cpumasks() for example is holding the
CPU read lock, but it doesn't take the wq_pool_mutex.
apply_wqattrs_prepare() has a "lockdep_assert_held(&wq_pool_mutex);" .

I can wait for a v3 of this series so you can construct the public
API the way you prefer.


--
Chuck Lever


