Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA875F57DA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJEPxr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJEPxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 11:53:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E648E8F
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 08:53:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295EYw30021396;
        Wed, 5 Oct 2022 15:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8K8AJH02DYKgUdmO6iQDD3ucDSBrBD45Xoc4KLyEqUM=;
 b=PWYc1Ttnh2id26nbqp9XCbOHoLRyQFpnZ0BlR67cjpJ1f+eBv0AgZ8EV4gAWqFahGZMF
 UUh5QbpLhvmLdo62N28niZxIDtaLdb8aKDwvO79L7hjcOlJkG+SjOtJtCjaDNliRfA2W
 mwGfnkBWM9ClaTuT5hkANSm+uJL+bFKaE/LKW8WKEnkQA1sY70W6V2sg2nEodqkNugi1
 3D4E92hRR3pkKnlRvMkJpYXdCTRmqOp2PROPbe5fnw8qmHWodcg+IjdNfDuB0uJ3Thq1
 milgIwPvPUHu6fmGQXz4JGlDOGEpQ4tIjBBX8yPqYxY0HG6E+LpKBYChoTAZxVhlbZCi Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc521w2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 15:53:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 295EYHEp003790;
        Wed, 5 Oct 2022 15:53:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc05ek9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 15:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5AxjhIzlY/DPRQwNfn1GsehDSp3AXxvR3uOU+KuaD4pe5lfliVPc+qaQ1pV09cjvO1Md+tb9OvnYdbpJLu5EnXaC/X6WwVkVnxFUYWwjludGy2/5A5RdpsL7Shbb83Qkf4IV0gpj9rc9Xosyeh8qhaWxXo97twZtY+HxmXWmI0JYhZeAuqwFw7/csbd9YdDpzXgUvPakl+X8+MTWfHDTWH0/gh7HkZYrEt5NkWf2NYLkmMfWfIeaT1Yx+su7Qhv1P/FlMOBorjjr5BUonkpYTcqlcT4Bc6SNT+jV3PAxG2IHn0O/cAy+F8JGLJ44HqtGJ66IG1zeBUYtsw/vXekLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K8AJH02DYKgUdmO6iQDD3ucDSBrBD45Xoc4KLyEqUM=;
 b=CVgAG+3TRrULs6jjMB2mC+YOEEZVr7LYJfEognZMku4ThG4KXTUzweUJcHnQL5MMP2HsICy+t2JtBIxu3yENGujgpPdcunwFB7CZ2XX0sa9fVmirP1ZmKKuGZtV5A/oskVwi3N+RJFHd2UlF1qj9aCkq5gnc3nU8W5fnR/U718OOXMao2tmDuaZZvAGk6w7264lyDnJhneBHEHuBJKm3T7HhvtmtWJ1LqoJrwBUXFcrqVNdJyo8fUwnmIYBhNnvt4XPryPESZT2Ro2xBD1/gqcMqAxSTOOGVpRdJoOHI1TeivkX6F5BNg1ytZmsSrMaVdu/49RDkq38k8hsFj5OOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K8AJH02DYKgUdmO6iQDD3ucDSBrBD45Xoc4KLyEqUM=;
 b=PA1kJUU6vUbtbi3bAgiBfHSZybdR9QH7XlLUPzTymSc8NwjoMRxOtTGvNexjqV98sSbM89eizIPQuWBEYdTqZyYBQoLVhahXkxcEh/Sw8SKO44nihtM2AD46zM0ZhK44nsGz213R/TkvoSJx+7fe0/B4947CRR0mDooxBVgqnrk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 15:53:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 15:53:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
Thread-Index: AQHYx5rrmfCuFExeO0iyVxj5F6vj1q3dsroAgAAhhICAIjXdAIAAC/AA
Date:   Wed, 5 Oct 2022 15:53:37 +0000
Message-ID: <32166C4B-FD5F-4F81-9CDF-7961BC140A89@oracle.com>
References: <20220913180151.1928363-1-anna@kernel.org>
 <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
 <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
 <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com>
In-Reply-To: <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4355:EE_
x-ms-office365-filtering-correlation-id: c3e47c61-1cb1-48a0-eae1-08daa6e9c3f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBl9kxI7D5mvaVkO/rs/plM0boql3jgyqxDcAEtQHUampJ0X2EV+jKbVa7IvY8R9QfD8vI5+unyyg3zJp/JztIwEfDxmMUe3vVkSvYhaSwz4Azb/J09XBv2vKdRksaUrLkC1RtHZOJP3GSloZomXJzxCW2RUWNa8TGrTth7mjahbVfeSwF5tfBTSyE3p4V03jgYD92InfwRiUSa3Wqqk80ZQZGIriBSyxD2NTQ5Ru4gv7zeJ3ptg7TTEJeR4o3nVRAr1SI/Y/musuvr8T3bmc0pWL9r0z9oKj3BmFgSsq862uF0zeNtquzb1x+b7QdPO06wZ6nj7YBt6KrZ+fRa8CYZWYPRaMh2kq7iiQMnZnn36hK2mrBO1iwLdp6gr7Jr+ImnDtV/o0A72BIoQBhy2WgyDBqT1o0iDRT4Lqrxw2lzo+Gg2EnoQX7tuT4QBg1z7SW5570l4ATwsNGkMeg+t/G3lnCAuAa1jX6nOoRtLKMtEn1gMwqkYv6Bj7Tsj0bKS3tBU69Cw9RIPIyPjvpBIa6KIuCFuQlLMXL/a/iWcMhScODTjClU2cGWqhpVmLXVAqN2XXANNa21VjXCZ1DOYddenwQC+rNuigHTZfKSxm0HSKeKOtzcfqHTeHz42zfWyIwynIIMMddqzWoXzjlP+Y4sci84m+0kX1JbZl+MUIf/Uth7GE02lv8iOqTsse4qDQOkHoByeFYEBYmICj5prygjYpARabJTQcRuxYOL1YW19yoNl5lvQy4e2cfUAhmgZIb69LbQMMAKW+Mtl5jHNVNz0OtIj4VQBP8ty2FNBME8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(83380400001)(4326008)(8676002)(64756008)(66556008)(66476007)(66446008)(71200400001)(6916009)(26005)(38070700005)(36756003)(8936002)(2906002)(6512007)(91956017)(41300700001)(66946007)(186003)(76116006)(122000001)(2616005)(30864003)(33656002)(38100700002)(53546011)(86362001)(6506007)(316002)(6486002)(478600001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jv2kwqPvXu2F1xtU/qaZd4tObL3Yn+CGEJOHWMgAe0pJOwxo0Y0wV78wjQaL?=
 =?us-ascii?Q?Ar4psEIrel4k39yu1qjJ76SI3vUfNfhWNEnqzXFkqaBKzSOYJnlGuDJnOamm?=
 =?us-ascii?Q?/Y9Zb5T3jtSlwTDqiEPlg1Q436DwGfx+aRasfkJb8IYjcySVy3lYZmh4X89h?=
 =?us-ascii?Q?6sgmUMnrrz46A8yuY9+tZNnEfTrZg5ZuNnLaFkpDlG/Y90vlFiTinDJQr9Zq?=
 =?us-ascii?Q?ThynRJAByccqrhbkElWv0sZgoXn3T+tr0klYX7WHbfin7xjchtrhplJDJIZG?=
 =?us-ascii?Q?csNXI5W6TSg1+GmveFfU7O1RDRHNwuusXKlJQY20sGa7kLWuTHVoDeoFi9PA?=
 =?us-ascii?Q?ajh6oDn/VDwTGvA4Sz8S7bqg+SwyXrBxQHdzjU6OOu3oSEJdlR3o2TRYUBn6?=
 =?us-ascii?Q?6uGnvUu/PD5aZHBBtE7oaPlxO3UXU0CYq3YfCmY6LbeCvBEZGR3ylweG5W1f?=
 =?us-ascii?Q?8zH3YYDhko3coiNlJp4GFgPEvet76HqPUCEhZKva4kwBbPVCA+bzx0tmYUAn?=
 =?us-ascii?Q?jwfwezlooc67Xh40Z4ccPIMowfaFrfDKKjRsvDxHLp4zwgupx1I8FlCWBLmy?=
 =?us-ascii?Q?zZSm5TN6Q7w309gdgnN3C+RlZjFVMwMY99QGsAAqcukxNI7eb1CpeBc+lPZo?=
 =?us-ascii?Q?tvv91mTnqoM/nD/3gUvnsBAcT0eoOFxlVfFcfALyZEE+qWSssnj6i7pf3W+M?=
 =?us-ascii?Q?n0lU5PTm7goMTmsUSFaLItzBIHHrlgsc2QRMcww1N9zWObRrOYlFghfGdQFV?=
 =?us-ascii?Q?haVumX+cn2KE05l/VkVcO4qSnFsWvyDzLSdcZ13SLB1UOoZ/RPKWO5Wp3I3r?=
 =?us-ascii?Q?Le5ZJkvNrrcX3Q+J8t8ZEjc33963zvwgfCbWCXMG/mMqWbW7+TcXLBxRFkli?=
 =?us-ascii?Q?92bfuXfQDAtqz42LPqpUh0m2ky74S+y3wts9Tk4AZYeSpdMMW+tx3+iGLbbP?=
 =?us-ascii?Q?YHd/VoijMO2M1IqV1KVXjgSBjg6LjOtnmvoBsr12ucHPscxc8dpp1jZpFhkr?=
 =?us-ascii?Q?LE6ICy4xGdBfdyU799PVK5P7k/rTK70E/ba6DPvStvduwplzaIfrXxHbykBr?=
 =?us-ascii?Q?2j52XG98dtSDO0mE0R6YGVN3BcdRzqVEXZ0RR5XL6QFg/udYFrZZwch8vQ32?=
 =?us-ascii?Q?jN4ZGrtpCCJKg8T4hIf+5a/YiQYeto1E4M0YJNtUebaJ0YhuUokCq4COXQ6e?=
 =?us-ascii?Q?sUf0RZVvmJ2ABZp+Xdp2erFP273jRNCaXQ4YfHFkxcRbj+D9wlDgMnnA3Bpd?=
 =?us-ascii?Q?Lr7/w/hIJGjnOr6haNXt8VZ2JR+XVJaZuqDe/VklLNmTzvJGoa12Z13CEP04?=
 =?us-ascii?Q?0HwoovFKocuIhBjWwPRnk4GRC+UNDlmrVSguxnz8OWDdC2sbiaWNwmjyBEWP?=
 =?us-ascii?Q?EQ/Va8zR/fgSyXs2DrpwZyGUha2YkJDt+YMheqVMr2+9i0hdjojMLi4bJ0Js?=
 =?us-ascii?Q?T8eHAfP1suCGMwSjVQGEDL3Bo3DtgC+NeArZ9fBi5J7yQ8YjQqutCTnXwSn0?=
 =?us-ascii?Q?0D4ptvBPxcLQh/anHNjj9vO3wd/zEgQgFxgII13JRYVbfJQGvzHvWdjOryWx?=
 =?us-ascii?Q?gbC9pbVsSTleV5RNsjjpA8r7NsAOZXOfnCzcSZUoBq5euwFZVWydURCyXYtm?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9A595C72E4C0A44AECEBF92D7DE5DD3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I8P/1Z8fK1FcQQOpiHqWQwKer05I4DldD8okVcl/jMPa4at11U0pL8Ni8qJRX93C7BBRubZc6i2b1gaNIZ9ZjxmKLHBuAqpW0piWXr3OvBHeKzTuPNp1DoybRpM22EcUPhTkeC8zgTe2X37rkosyfpI8XSsuBE2r+8nTgPGGU5P/ejpSzXGFni4sHQDVZpeLlaqUZxyFFq6UaAWuZU9YgDa4lXKuc4pv50vVJ0c5wp5ak3HPMg8tk1ppzE7ssqH3Xz6hGMdyAxlg6N15uZf8i3kwEHxJqYjOWsTUffBzforKjluHGv2euSAgzewrm1OAxsasvr5O/n6P2pq9ItiVCQ3VuRzdiXk/2md2b5NKhc7lUgPq7w+/+lfNcTdvWiOyLxJVMSr7FVWQBWvqBbmsfr17wawDv1Q78Qa4XsW/kJ6s1x1JdIlfDEfhtcLUDVAfvAcjaw33AfWCExx1fHduQNROyXBKKH7ezuBgHQDj2ARdSFiSRMehUmx6yulu9wSJwdk3Z5partGQN5co36n8pIA8usNlGBDaUgvWsgrydSK78b1R5S8HGemftwZKkl8Ty/mlp0QgOcUvlVrevLPWEwRyMzCD/Hg9RLLEinDr5m7d8h8D00iLR1LwGZ5w734Dunb2tZzrnIOo+aPiPvuMkp3B4jAYyNxCt/5vuROJHptNomG47RHbywzuxGKlMJSZz93Io5o07dUogx/of/1Xa6i6UPZ8Co0Rbum6WNQ3mSW7pnhfDNftUqMvVMtQSu3BXeEVqd08pRQVS4hKClAu2V14p+eadbjuNrvMWj8G5fA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e47c61-1cb1-48a0-eae1-08daa6e9c3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 15:53:37.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxWUazCpqpymf14qttZ9wHoYkb4AGxY9qeGyhjbC2H1KBliIhO6dgO5oexGeQvWjsH4hRGaMN21Vxp9T7dEhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050099
X-Proofpoint-GUID: yx0ZkXL3jDzpieIwsHgFjgwurkgUSq4s
X-Proofpoint-ORIG-GUID: yx0ZkXL3jDzpieIwsHgFjgwurkgUSq4s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 5, 2022, at 11:10 AM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> Hi Chuck,
>=20
> On Tue, Sep 13, 2022 at 4:45 PM Anna Schumaker <anna@kernel.org> wrote:
>>=20
>> On Tue, Sep 13, 2022 at 2:45 PM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>=20
>>>=20
>>>=20
>>>> On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
>>>>=20
>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>=20
>>>> When we left off with READ_PLUS, Chuck had suggested reverting the
>>>> server to reply with a single NFS4_CONTENT_DATA segment essentially
>>>> mimicing how the READ operation behaves. Then, a future sparse read
>>>> function can be added and the server modified to support it without
>>>> needing to rip out the old READ_PLUS code at the same time.
>>>>=20
>>>> This patch takes that first step. I was even able to re-use the
>>>> nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
>>>> remove some duuplicate code.
>>>>=20
>>>> Below is some performance data comparing the READ and READ_PLUS
>>>> operations with v4.2. I tested reading 2G files with various hole
>>>> lengths including 100% data, 100% hole, and a handful of mixed hole an=
d
>>>> data files. For the mixed files, a notation like "1d" means
>>>> every-other-page is data, and the first page is data. "4h" would mean
>>>> alternating 4 pages data and 4 pages hole, beginning with hole.
>>>>=20
>>>> I also used the 'vmtouch' utility to make sure the file is either
>>>> evicted from the server's pagecache ("Uncached on server") or present =
in
>>>> the server's page cache ("Cached on server").
>>>>=20
>>>>  2048M-data
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 71=
2 MB/s, 0.74 s kern, 24% cpu
>>>>  :    :........................... Cached on server .....  1.346 s, 1.=
6 GB/s, 0.69 s kern, 52% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 69=
0 MB/s, 0.72 s kern, 23% cpu
>>>>       :........................... Cached on server .....  1.394 s, 1.=
6 GB/s, 0.67 s kern, 48% cpu
>>>>  2048M-hole
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 76=
2 MB/s, 1.86 s kern, 29% cpu
>>>>  :    :........................... Cached on server .....  1.328 s, 1.=
6 GB/s, 0.72 s kern, 54% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 73=
9 MB/s, 1.88 s kern, 28% cpu
>>>>       :........................... Cached on server .....  1.399 s, 1.=
5 GB/s, 0.70 s kern, 50% cpu
>>>>  2048M-mixed-1d
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 59=
8 MB/s, 0.76 s kern, 21% cpu
>>>>  :    :........................... Cached on server .....  1.445 s, 1.=
5 GB/s, 0.71 s kern, 50% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 55=
9 MB/s, 0.75 s kern, 19% cpu
>>>>       :........................... Cached on server .....  1.514 s, 1.=
4 GB/s, 0.67 s kern, 44% cpu
>>>>  2048M-mixed-1h
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 63=
3 MB/s, 0.78 s kern, 23% cpu
>>>>  :    :........................... Cached on server .....  1.357 s, 1.=
6 GB/s, 0.71 s kern, 53% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 64=
1 MB/s, 0.74 s kern, 22% cpu
>>>>       :........................... Cached on server .....  1.396 s, 1.=
5 GB/s, 0.67 s kern, 48% cpu
>>>>  2048M-mixed-2d
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 70=
8 MB/s, 0.78 s kern, 26% cpu
>>>>  :    :........................... Cached on server .....  1.410 s, 1.=
5 GB/s, 0.70 s kern, 50% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 71=
2 MB/s, 0.74 s kern, 25% cpu
>>>>       :........................... Cached on server .....  1.474 s, 1.=
4 GB/s, 0.67 s kern, 46% cpu
>>>>  2048M-mixed-2h
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 72=
2 MB/s, 0.78 s kern, 26% cpu
>>>>  :    :........................... Cached on server .....  1.374 s, 1.=
6 GB/s, 0.72 s kern, 53% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 75=
6 MB/s, 0.74 s kern, 26% cpu
>>>>       :........................... Cached on server .....  1.349 s, 1.=
6 GB/s, 0.67 s kern, 50% cpu
>>>>  2048M-mixed-4d
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 68=
0 MB/s, 0.75 s kern, 24% cpu
>>>>  :    :........................... Cached on server .....  1.391 s, 1.=
5 GB/s, 0.71 s kern, 52% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 62=
6 MB/s, 0.72 s kern, 21% cpu
>>>>       :........................... Cached on server .....  1.456 s, 1.=
5 GB/s, 0.67 s kern, 46% cpu
>>>>  2048M-mixed-4h
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 74=
3 MB/s, 0.74 s kern, 26% cpu
>>>>  :    :........................... Cached on server .....  1.345 s, 1.=
6 GB/s, 0.71 s kern, 53% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 77=
9 MB/s, 0.73 s kern, 26% cpu
>>>>       :........................... Cached on server .....  1.421 s, 1.=
5 GB/s, 0.68 s kern, 48% cpu
>>>>  2048M-mixed-8d
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 68=
7 MB/s, 0.74 s kern, 24% cpu
>>>>  :    :........................... Cached on server .....  1.366 s, 1.=
6 GB/s, 0.69 s kern, 51% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 70=
9 MB/s, 0.72 s kern, 24% cpu
>>>>       :........................... Cached on server .....  1.414 s, 1.=
5 GB/s, 0.67 s kern, 48% cpu
>>>>  2048M-mixed-8h
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 78=
9 MB/s, 0.73 s kern, 27% cpu
>>>>  :    :........................... Cached on server .....  1.338 s, 1.=
6 GB/s, 0.69 s kern, 52% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 77=
2 MB/s, 0.72 s kern, 26% cpu
>>>>       :........................... Cached on server .....  1.438 s, 1.=
5 GB/s, 0.67 s kern, 47% cpu
>>>>  2048M-mixed-16d
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 66=
1 MB/s, 0.73 s kern, 23% cpu
>>>>  :    :........................... Cached on server .....  1.345 s, 1.=
6 GB/s, 0.70 s kern, 53% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 71=
3 MB/s, 0.70 s kern, 23% cpu
>>>>       :........................... Cached on server .....  1.447 s, 1.=
5 GB/s, 0.68 s kern, 47% cpu
>>>>  2048M-mixed-16h
>>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 78=
0 MB/s, 0.73 s kern, 26% cpu
>>>>  :    :........................... Cached on server .....  1.363 s, 1.=
6 GB/s, 0.70 s kern, 51% cpu
>>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 77=
3 MB/s, 0.70 s kern, 25% cpu
>>>>       :........................... Cached on server .....  1.435 s, 1.=
5 GB/s, 0.67 s kern, 47% cpu
>>>=20
>>> For this particular change, I'm interested only in cases where the
>>> whole file is cached on the server. We're focusing on the efficiency
>>> and performance of the protocol and transport here, not the underlying
>>> filesystem (which is... xfs?).
>>=20
>> Sounds good, I can narrow down to just that test.
>>=20
>>>=20
>>> Also, 2GB files can be read with just 20 1MB READ requests. That
>>> means we don't have a large sample size of READ operations for any
>>> single test, assuming the client is using 1MB rsize.
>>>=20
>>> Also, are these averages, or single runs? I think running each test
>>> 5-10 times (at least) and including some variance data in the results
>>> would help build more confidence that the small differences in the
>>> timing are not noise.
>>=20
>> This is an average across 10 runs.
>>=20
>>>=20
>>> All that said, however, I see with some consistency that READ_PLUS
>>> takes longer to pull data over the wire, but uses slightly less CPU.
>>> Assuming the CPU utilizations are client-side, that matches my
>>> expectations of lower CPU utilization results if the throughput is
>>> lower.
>>>=20
>>> Looking at the 100% data results, READ_PLUS takes 3.5% longer than
>>> READ. That to me is a small but significant drop -- I think it will
>>> be noticeable for large workloads. Can you explain the difference?
>>=20
>> I'll try larger files for my next round of testing. I was assuming the
>> difference is just noise, since there are cases like the mixed-2h test
>> where READ_PLUS was slightly faster. But more testing will help figure
>> that out.
>>=20
>>>=20
>>> For subsequent test runs, can you find a server with more memory,
>>> test with larger files, and test with a variety of rsize settings?
>>> You can reduce your test matrix by leaving out the tests with holey
>>> files for the moment.
>=20
> Hi Chuck,
>=20
> The following numbers are for 10G files that I created on Netapp lab
> machines. I narrowed down my testing to files already in the server's
> cache and read with directio to get the pagecache out of the way as
> much as possible.  I did 25 iterations this time around, and included
> minimum time, maximum time, and standard deviation in the report.
>=20
> The following numbers are for XFS:
>=20
>   10240M-data
>   :... v6.0-rc6 (w/o Read Plus) ... 95.804 s, 112 MB/s, 0.42 s kern,  0% =
cpu
>   :    :........................... Min: 108.000, Max: 114.000, StDev:  1=
.555
>   :... v6.0-rc6 (w/ Read Plus) .... 96.683 s, 111 MB/s, 0.42 s kern,  0% =
cpu
>        :........................... Min: 107.000, Max: 113.000, StDev:  1=
.481


> And here is EXT4:
>   10240M-data
>   :... v6.0-rc6 (w/o Read Plus) ... 95.419 s, 113 MB/s, 0.43 s kern,  0% =
cpu
>   :    :........................... Min: 111.000, Max: 113.000, StDev:  0=
.557
>   :... v6.0-rc6 (w/ Read Plus) .... 95.764 s, 112 MB/s, 0.42 s kern,  0% =
cpu
>        :........................... Min: 111.000, Max: 112.000, StDev:  0=
.200

For this case, only the single data segment results are
interesting, since that's all the server implementation now
supports.

The ext4 results show that the difference between the
average throughput results (112 v. 113) is larger than the
standard deviation: thus, the slower result is not noise
(differences in significant figures notwithstanding).

I've tested on 100GbE (TCP) against a tmpfs export using iozone,
and consistently see 10% lower data and IOPS throughput with
NFSv4.2 READ_PLUS compared with NFSv4.1 with READ.

Maybe tmpfs is not a real world test case? If you don't see a
significant difference on a filesystem that stores its data on
durable media, then maybe my 10% result doesn't matter. But it
does expose an inefficiency somewhere.


> Is there anything else you want me to test?

I was asking not just for more precise test results, but also
for an explanation/analysis of the differences.

At this point I expect the problem is on the client -- perhaps
it is not aligning the receive buffer to expect a single data
segment. Do you think that case should be optimized on the
client? For typical small files, I would expect that single
data segment reads would dominate.

Do you have a way of assessing whether the client has to
re-align READ_PLUS data segments when it receives just one
of them per Reply? There might be a SunRPC tracepoint that
fires when re-alignment is needed, for instance.

I'll add "Simplify READ_PLUS" to the NFSD v6.2 pile, but IMO
understanding (and hopefully addressing) the performance
difference here is key to the success of the Linux READ_PLUS
implementation.

--
Chuck Lever



