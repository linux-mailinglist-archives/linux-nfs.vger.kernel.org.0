Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20F153AB1A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiFAQiC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiFAQiB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 12:38:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCB3B561
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 09:37:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251GNKe4021292;
        Wed, 1 Jun 2022 16:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NfC0oNyu0/vniUrynEMOCTsGQuCov0OtPZIsP3LdVho=;
 b=d8ImxsruGKgpFnaJWTmY15QvqkAvICRYZpcXqrVj3t5Qd6RzaEMf/B5A5AgLmQV0aRut
 RKmGpCsW8i5tVr1OalpvyyOM23kUZxd7f9FRYkQL2et816nHQiwAFkRYqmNE3y+FkWAT
 gu/1fszyhjcF2M01Ye4Jjxm0Ev/gVEl3rfRRPFLlWo3/7R5EsOGXnKO5THH67uFAmbvi
 zSUI8Tt9u0g4iWajx3yDRch1MtyZtQZH6LoSmD8Q5mWjYBQzppCkI7vVkBteNtpolg/y
 0TfuKM6YiRHMe3dsQlOHCB+ELiYZaQZdkbwo4rR1ImnpeDpYl0TPYbx5jGYbGQ4b6q1x CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm7xre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 16:37:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251GVVYE036787;
        Wed, 1 Jun 2022 16:37:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k0mmrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 16:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw8myB0+uRp1oUQUT+xocGpkUB7zx3keGIyHcePBW88rw2VQPF42zMNVwP2H9Q4UaSXMYfpkKBSkZn5npgvVZph85F9IBrLGHjyxEOkoRSO7x1m3CnmBdXSPm/H1TV8nENtYnuCjRpIpuRZnZh6yXwHGs/1T/wP+bITBeZsAk1VqGLbXjaQbYwjhSrXgkO3Z0VU3RmT5souefHSnGoxL2z3KO0Jlxpg5UM9JTTj++KEUHPrFpJ9s4VUZWBzXzpFcq8xIWLn1W08wY3B4gwbbqISTPjIBmiFy0dCUoUESAx44YRxaWB+EMCaqqmdZHcCdljx+3LXn0ru45nSK1ILnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfC0oNyu0/vniUrynEMOCTsGQuCov0OtPZIsP3LdVho=;
 b=kfNU/wPBJ0HTLbTGHfoWax3PSE2v4EnDP5fsE4xHtNi0VKRha2hry1z3MD33Xi6+bJ8qKPr1NPdtKIYFXM1ttwUBfYwpRNg4oVkWhKQXEJPKVLtXfIQfOygGDlhPOOBNEINuXLtZs1ghXTSZKTWl4yjk0c0VBemh3eqVGI+8BrgnKbBJh3P9tB5SieQRDvsOh8DyIQdMXWhlsVBhHMMgSkOPHcUcLq43mrDw1WpnFylBwuCbJd6mFe0aZVrsPgzin4fYnmExocrCgP08mYHbNN80P2mBilNodTMMltHz0QVxlfPhrP2cUsxMU5yRgRjdMqnJvq1WmhlsrFYDCNvDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfC0oNyu0/vniUrynEMOCTsGQuCov0OtPZIsP3LdVho=;
 b=PDaEzgyf0Y+Ol1m/4CSSmKQVOofc3C2R4FDcesYJsbMiTWZzvAF35o/Ls6UiOrVR4O5xSDJDk3CfRxIT7oOVyL906iuNCQu0lTkOB1B4/gjMZ1WbPplibINnlZpiyxTfVW67JPEljnTU6Lfbt5J59RcqBT8LNcLY5RMMUY0r6fY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3513.namprd10.prod.outlook.com (2603:10b6:5:17b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 16:37:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 16:37:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Frank van der Linden <fllinden@amazon.com>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gCABnuxAIABBV+AgAAHvgA=
Date:   Wed, 1 Jun 2022 16:37:47 +0000
Message-ID: <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
 <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
 <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
In-Reply-To: <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec54ee7d-c131-4714-ea4f-08da43ed0f5c
x-ms-traffictypediagnostic: DM6PR10MB3513:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3513BEB8E076DE843C67143293DF9@DM6PR10MB3513.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrsNRK+AzDEWipCyGNbbTR2GbD2SJiWNC3JdJCxGsR1XDG6l46sj+ced+Z6MLemzT8yEJpDw/SelBkh9BoQ7nfml2aH2RXsGUqSZG0EKt+Zr+sh1HP9yPTBfqhL09yyryjiU2DATuQV+eSgfjLEfwuu2FyG9FhG9yEFyj3bKYG+y0tdMSF3QXhJQOggfMcqjXA+mm0r8FeVSJDi2Q/AxA0l564MvVvqmDXELhsLIduR57TtZrm1WX4k2vDY1TJoaHgcGPFJ4PNIdPqQO+usn6sV5CdbfvzxkgjpGZZeYg8CdHxCMXw+gRoC6zEXxEqdsS7txDdLSeTWb4JK+Jaxy3aekKbLR34YlYUUMbtThlayt74BaX2SvUZFFLjMUB2ijSgg4jQGUcv6Pi3C27OJ1xX2MudvhtR1u9AvMrqCXVKmcKOyf35mlumMhSZ/5IRVwP8JzX1HXRWrZPtR1dclGlFbK1KdKk8gdstD4RnBuTnsz0coQa8I4vC1HjpDGoBevsgyDm4JkvA2rZy7/coQhTG213OaSaIIh8n15s3eFJwzKzaIr7oT9qUzzYDPNbFQX4p+qpLPXKZPue0tnFmLF+FdMIPMGm7U8mpOaKLXongFjCNfYNwtRnzim4cm1OX5EIikswCktsE3m95y/ib1KyxO/tKJRpNeETjNaCBLCMNKQwv+6RxFjSxPlJ6qNaaMfb/hPcVH5lMZaneRSOZyDJ/QNnBRiRJVdCVGuDRSwiAEsxSoIfgLKatNpYBQKrMfbEfY0Jrpss5yIdVxTz6PSC869cu1RXyPjc5RskJDSXMvR2aZVU4krrB7QW+X9xHagCNfiTyJN+j4RuTUPl2qX83kUlfwatE1XivD+3OTlQlo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(966005)(86362001)(6916009)(53546011)(5660300002)(76116006)(26005)(6512007)(2616005)(2906002)(33656002)(38100700002)(186003)(83380400001)(107886003)(508600001)(122000001)(66446008)(66476007)(316002)(66556008)(64756008)(91956017)(6506007)(38070700005)(3480700007)(36756003)(71200400001)(66946007)(8676002)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Cd8oidk15pYdDODvMp55+gGjL0JknXmtrUZ8+BWJ7FJ7bddOcL1lxNfBmCm?=
 =?us-ascii?Q?giw+IsrEiKkxAnxqgnmjTmVuZRDL1Kk3iGjlr341cNWutGa/Lkk9DMLS3EOi?=
 =?us-ascii?Q?HpnC1mfg6Rdv4l9K+Pc7lF4aEyFl8jDMUBCxvFf1gnuijaCpLWo8vvCDn/H+?=
 =?us-ascii?Q?ZM/1LqmJKPVReU8K3dIYw3m9bn22xDogwzuuJPBzyJ95e//qQy0R9kbaHuc+?=
 =?us-ascii?Q?skUUM+g3t9Cj/fA8NVnZts55vXENiFg2hm56JZrD3kKtJFvuA1H0k1NWCx00?=
 =?us-ascii?Q?xUkd2GRs+AExmmKwkIFou+xCzVSr51Sp8rjiOHHtD2buWtSA4WxpO45ZrCVx?=
 =?us-ascii?Q?KSKzZq1dKY1MSRCBJac+nct2EKRrRDGy0PYltH4PGT3re7IEFQOhnlDqeDAy?=
 =?us-ascii?Q?tpErs6t/an7sHvNGqluJNpmfWybRS48d+ra6stLkPl4VOQ8Hq/FuhPorpB5z?=
 =?us-ascii?Q?SwwAb+imXQnjyW0kpCwAibYaOD3QdipfUMwIZyifboJ5L5ASiwUys4aLIKg1?=
 =?us-ascii?Q?A1W1kpiSVxgc4zOP4IFug7lRvIWJprxm7CUI/sf7wArQCfdPsTPYI4jB86Zq?=
 =?us-ascii?Q?3hD4nWxIqHfFg5IUJk/migaHaEdiJ7l6IM6hluBPHksIrKnq+pYONn9wfGtE?=
 =?us-ascii?Q?vY7AXlTpBF+N5maeIzZRkcwTAP7YPLA1Ct48t5ETQS2vOfCihGyvTIj5/mva?=
 =?us-ascii?Q?v/nLctK/ftxrmk6BKOBs/N/IGLKBIIvXX7TTAmK9TKXDrcoQvLq/wKgeHsjM?=
 =?us-ascii?Q?VpNWQQk2eZJX7R5Mn3gETYU027JGMa85w5zDyhw3CXGhP6wjhH0WZjxkcOg4?=
 =?us-ascii?Q?v+SxS4dWSOy2JjfmndoKIQHo4/J9mEEhbaEP0srahF5exathz3f+0YeLe9kx?=
 =?us-ascii?Q?PSlbK29ODMl/CDRv9x7jqHLt3g09heosheAfYGacitjes4tuyCOxb82Ymacu?=
 =?us-ascii?Q?532W99xQa+9DGSHchiUQ6pWVaWFAajk9aWy5ff7n95IW7nSupN5q7iyTCW8h?=
 =?us-ascii?Q?v9aEJWAdNVpyAycexH8O0IPOurO8YG0U8mQpYHp+PkQNIobixUQufqJPRsyL?=
 =?us-ascii?Q?hYUz94lr1FJ5rLTMTq8eTVvKy9S2vmWhD9qH5nElxbPVzSgPc797jnfqEWdc?=
 =?us-ascii?Q?yLUM/JwVysAQW8NIgzybPDRuuMZTqS+TRTdrH/OQWG4j+GHcc2W/WUH8G0MH?=
 =?us-ascii?Q?b1XHyLZLbac+U5ZBSOCWN0S0GHBcox47vTyNmn9Azqqf7AbZksvHUHfV50Cm?=
 =?us-ascii?Q?v1BRqJELiqXhA2LROeqc0S5xPt+5FGSnYbkCL6QALS0BQUn5FcOrOKmPqez1?=
 =?us-ascii?Q?5kV6xQRLzWtAVSLq6/jbsu0ldF/VyFCObcEIMqr6B+obOvpviRgL6EQMOpKu?=
 =?us-ascii?Q?6UZhpD4sfb11h6lJtRE7p4vfqCkoayqVFabQJlgl5uY31/byNBixHOXEicwy?=
 =?us-ascii?Q?2av3HmogllZi76sWgEv/u0YuLjT08URy4zm6sMWxQYS4Qouc9vulk4quwPSB?=
 =?us-ascii?Q?AWLixaL6kd8Y3bRl7ybrUhGoKVswgw8SnW/dHDyiNbDmC2hQYeEe3/tMENpQ?=
 =?us-ascii?Q?vjZ/T0goiEgouIArmtlk7I45wZHNOqu1eFZ/N/Hdh1YkdYtAdbhQLxJ/t9yk?=
 =?us-ascii?Q?YHeIvi81T0EAW74Y+pRpBJ9/DQMgDs0MMRz5zRb+1Z7POvafN2sPl0NQn5bz?=
 =?us-ascii?Q?61S1WZL3XSxZjaTANMAo8R0e78VzMwEQVelyu/vJMppaYFOKrP5cALWWq8Kp?=
 =?us-ascii?Q?7qAFYxl4exWASCjjEHVxz03LZZP5AGI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1870259F11493346922B71BAB793BFA9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec54ee7d-c131-4714-ea4f-08da43ed0f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 16:37:47.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqcJKOR787uwPIuE74NhnR2sGk2sSHZcOH675hmYeCZCX44Lod/EfNYxvVxtRDUTgVdRTGnmLUGqdKFejkmucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_05:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010074
X-Proofpoint-GUID: zxa6WjT5yeKiioM3_wJ4nJ2dbo7kNyu-
X-Proofpoint-ORIG-GUID: zxa6WjT5yeKiioM3_wJ4nJ2dbo7kNyu-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 1, 2022, at 12:10 PM, Frank van der Linden <fllinden@amazon.com> w=
rote:
>=20
> On Wed, Jun 01, 2022 at 12:34:34AM +0000, Chuck Lever III wrote:
>>> On May 27, 2022, at 5:34 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>>> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com=
> wrote:
>>>>=20
>>>> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
>>>>>=20
>>>>>=20
>>>>> Hi Frank-
>>>>>=20
>>>>> Bruce recently reminded me about this issue. Is there a bugzilla some=
where?
>>>>> Do you have a reproducer I can try?
>>>>=20
>>>> Hi Chuck,
>>>>=20
>>>> The easiest way to reproduce the issue is to run generic/531 over an
>>>> NFSv4 mount, using a system with a larger number of CPUs on the client
>>>> side (or just scaling the test up manually - it has a calculation base=
d
>>>> on the number of CPUs).
>>>>=20
>>>> The test will take a long time to finish. I initially described the
>>>> details here:
>>>>=20
>>>> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllin=
den-2c-c1893d73.us-west-2.amazon.com/
>>>>=20
>>>> Since then, it was also reported here:
>>>>=20
>>>> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/=
T/#m8c3e4173696e17a9d5903d2a619550f352314d20
>>>=20
>>> Thanks for the summary. So, there isn't a bugzilla tracking this
>>> issue? If not, please create one here:
>>>=20
>>> https://bugzilla.linux-nfs.org/
>>>=20
>>> Then we don't have to keep asking for a repeat summary ;-)
>>=20
>> I can easily reproduce this scenario in my lab. I've opened:
>>=20
>>  https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D386
>>=20
>=20
> Thanks for taking care of that. I'm switching jobs, so I won't have much
> time to look at it or test for a few weeks.

No problem. I can reproduce the failure, and I have some ideas
of how to address the issue, so I've assigned the bug to myself.


> I think the basic problem is that the filecache is a clear win for
> v3, since that's stateless and it avoids a lookup for each operation.
>=20
> For v4, it's not clear to me that it's much of a win, and in this case
> it definitely gets in the way.
>=20
> Maybe the best thing is to not bother at all with the caching for v4,

At this point I don't think we can go that way. The NFSv4 code
uses a lot of the same infrastructural helpers as NFSv3, and
all of those now depend on the use of nfsd_file objects.

Certainly, though, the filecache plays somewhat different roles
for legacy NFS and NFSv4. I've been toying with the idea of
maintaining separate filecaches for NFSv3 and NFSv4, since
the garbage collection and shrinker rules are fundamentally
different for the two, and NFSv4 wants a file closed completely
(no lingering open) when it does a CLOSE or DELEGRETURN.

In the meantime, the obvious culprit is the LRU walk during
garbage collection is broken. I've talked with Dave Chinner,
co-author of list_lru, about a way to straighten this out so
that the LRU walk is very nicely bounded and at the same time
deals properly with NFSv4 OPEN and CLOSE. Trond also had an
idea or two here, and it seems the three of us are on nearly
the same page.

Once that is addressed, we can revisit Wang's suggestion of
serializing garbage collection, as a nice optimization.

Good luck with your new position!


> although that might hurt mixed v3/v4 clients accessing the same fs
> slightly. Not sure how common of a scenario that is, though.



--
Chuck Lever



