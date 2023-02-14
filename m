Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21C26967C2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjBNPQS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNPQR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:16:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD118147;
        Tue, 14 Feb 2023 07:16:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EETRrM003456;
        Tue, 14 Feb 2023 15:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/NkDIbfkNfJQMB8+dXtvCq93eCNCA5QXbt/hVzVLuuY=;
 b=QxpPHee5x5fP5OVkawkZFMXok/MU5WrEQLVkWGjH94jDxdHtNkQA9KrXJ1M5fAk6VMUS
 DvwxO/GtD/W1flPim/TwN64Tk3Y1vd2MfiEXhtkSMIqbOvvWcqTawPaKTc/GWfZhfTNc
 7G57K9KTcFPcxktj/1FrWZ3PMXmaEonaGxV1IjrwS5o8XYvoIAzjBD6ydpuFGsfVGTKX
 U1KTkj1yjhmW6xRbZg8jBu4HC6vb7gP1ODiDTCli4cDdxh9velorTyfGOiXXJITpYHsl
 rYZhoTxz93ZO61K/KuBmAWdQZ1GcSV1zPq8zzP6m29unFuBvrVlfXNlDaiTJw9uru3zS RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0wqk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:16:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EELegP013540;
        Tue, 14 Feb 2023 15:16:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5q2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZsIOqg946yO7kuqU45vFJ/MhfvWv5Tau35hSiX88Q1zIseOkpriVR09Gizc2QqMLyixDCDUBs4T0+azd1thD64m+gbSvs95Q5vS6Uriaa9fy9q+frPQSP2y0AFDhtQ9hlXN+E5dEYvu4wmptniAnfBa+j64sYwHhJMgMZMCTJpKv+dgWUactegRUgrL4VjJjo4xTCu5CRH3UkzFCH0m1ThzdgR9K5IYjCXilPvyvwiO+zeJYN9oPgLaD6RmDrwwLTZM9XIsNPZoDNVdSUcGoBB8xEXLzfQz0zN0tHysqzPUX/Pigb63tG5aHH7N6CIBa1MIrozk0qk7Yn6R2egodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NkDIbfkNfJQMB8+dXtvCq93eCNCA5QXbt/hVzVLuuY=;
 b=ejvlRNfolfkGulb7jN0ecyOi4LTKWwHDAJ5adggbF34R4Smw/IYFQNqdOvLwl/zBwMHekWgRXjO46ZRLvGoGcOBTzkeJayHA3F0UJDLNdAeISwR6kMK8WsDX9Kyqc+nz49y5RBfNurAeRg2ePhGOJxtHkJ372PpfazFD+oO3XMHc+zfXZiIjsaZiYk4lHK0rs8EbydbtXAa9iZkIjaHpPJX1+9A1lMASpQursWBMjJJb4C3icYtrtbnFYQ3SAdBwAvkJqkIAjU0CgqS+zIvXTFx4BYmJ5M6bayqi81R4B6cJZrwP4s+w93ah7H8p17gUlBkYhqv/pXTtJnNbEB4RPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NkDIbfkNfJQMB8+dXtvCq93eCNCA5QXbt/hVzVLuuY=;
 b=m/gBJxC7zkl2Pm83EHirqfovo9VMUYDyeNE/JuH1nbZvuXiINNEw2F0AKiTN6IsADRpbi1I71lfp5hEyRn2xl29PL/09kYmJ7o9vWJgDQrHpYAgyWf0mLLs5S9Pgd76589uG0LIFSf0WhREr9x8FG0hRdBlW7wHHFCIbeSzfC/k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 15:16:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 15:16:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <error27@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: remove redundant assignment to pointer dentry
Thread-Topic: [PATCH][next] nfsd: remove redundant assignment to pointer
 dentry
Thread-Index: AQHZQH6rVnUd5+nphU2O0AMSQaxqqq7Oh8uAgAAFv4A=
Date:   Tue, 14 Feb 2023 15:16:10 +0000
Message-ID: <A0A239FB-249E-4C50-8276-D6DED71D8C3A@oracle.com>
References: <20230214141428.301121-1-colin.i.king@gmail.com>
 <Y+ug53kWXe5tqZbw@kadam>
In-Reply-To: <Y+ug53kWXe5tqZbw@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5175:EE_
x-ms-office365-filtering-correlation-id: ba4a8bd0-1082-4639-11ab-08db0e9e6747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk4RwCa7FW5SarXAuHgLkMikv1vhPb8gLZeb4ZJ3o7uBcZxnGjPdAru0EtyzD72CN3Bp0hJ/cQzY4WcW214AeYwZ/HuaNxoAYLrEdA0aLr0B/uDhP31HVV9AKBndZG1tmH4LV6j1FR1nyUznUnusjtSd8HI3GifR8c9RZT8HKQ6cWWw6gDnXiU8wmkoKVPt1JmQkgtcxRn08Rm5U7coQ4AV3EKbnzCsVudIHGHZ4E9YJcfT0UANB5QDXoDyNLP+5ZGQlIPl75Dcv6r33P61iDvCjLt6Q8EjoHRXf03aGD+JGreUaWYTKY3HQgb8NizO4zjmHr9Q1lDVKIL72/i2aA41gb3N1/fSyIXKUPTqyQiwH47ZmSREHSbdFgTyD2CbRk7opecvMdQ8hz+s+gIBxIseEXSMsQSwTq60kPm5JyuX/501uPQuIQJEeIIJLPO6HL7nHp0j21at4gfEjOB5NPBDNdL95DbEPrWoXhEFg+GkBj0z+43poXc+ZPxeXk+Tk6lZEvwq3wle/G+LQnaS0WrcEfhV8QrBuO6ylO5ZBAJNs8Zk6pzyrWxckErQZ4B4yHmsPz0s8p3nR/Udb581cWlbc83Uvw05/vH/XtFQ7zXKFWY7YaKnIZNouSZYpcUzCTO0Qyt3kQiieuqLZb/bfK1W+m9hDwRWr0QpMmit1fzX0u5jPkwuKmjdmUXQls1KYmppLscO2R37TYbSLHXQEYmH1xETbT5aCIGNU4lDw8WI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(66946007)(36756003)(33656002)(2616005)(83380400001)(122000001)(66476007)(38100700002)(38070700005)(2906002)(41300700001)(4744005)(71200400001)(8676002)(54906003)(5660300002)(8936002)(53546011)(6506007)(186003)(6512007)(110136005)(6486002)(76116006)(86362001)(26005)(66556008)(66446008)(91956017)(64756008)(4326008)(478600001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l7lujFxSABhOVl2uVhtyito7AAb8WCldiCbGXOkjTN0hZ6FDxsQ50u1/iM+q?=
 =?us-ascii?Q?+Fh/Gp59C7VxSf3KccIvV/aUUZXC6Cocto2Qia4qrsXEwYryypMgLPkg26BV?=
 =?us-ascii?Q?0EqDeccZMFn45o80WY/CUOQIybwVBOx9YimgEH8k1mr8asvYu+p8CMfCISi3?=
 =?us-ascii?Q?AqE1RjDf8DalwxLL/9pBuvqcMO5aVuI0fgDGM5+ESWFa3HJHkfh7Plo1yStM?=
 =?us-ascii?Q?8za1x3QQMNsz7CXUTQAKvBuXqlFr4mrV57Bej54T76uQwnbesNPnppRoxfO4?=
 =?us-ascii?Q?KTSIPnLihYg0f7TQiW9PY4YgQeV8ZJFq2PCrfOnYUeGtBxaIczijc9/7v9JQ?=
 =?us-ascii?Q?v/l4snosDe4wfKS4qYt+/qwD5tyLLKCB0qpmHtnSVVYF3gdaxIU7VR2jtLmO?=
 =?us-ascii?Q?MqQGshxrkYc9CbyTkF4V9Ia16em92VH7jLlv5czagvfgMkKjJDY+9kYKChUy?=
 =?us-ascii?Q?9vrO044Qg2t7wpqSkG5YNxfSc13c8Yj1KzgS/ykAl2mfEceeWZCSbk3Fyu0I?=
 =?us-ascii?Q?fd08z/E5VVKbXs2wEOd0aqLJfM0YCHQk4n/h7kmYrOaEg2vvwmmjfC4Wd7YA?=
 =?us-ascii?Q?zczOjIuL2IMiwePLjJAWIiMGAz5jLEuSba55VUNHEb0Tg5N5L/nFXN9DB9E8?=
 =?us-ascii?Q?9+DNFVRrlc8Ww8zUvoLjG3lUbwHbMb7XjbM8F7clZAKwK3YMHYAoIcm6IawO?=
 =?us-ascii?Q?2jB43W8M0EsIgh3mdVeWSTXy4kGUzmr7+6/u2RS77tAnJfz232F6+VIPzi3O?=
 =?us-ascii?Q?Fmnt9bO2CyfcXMbvHYazZLBjAZv+JcvhnpKGqWrhZ/DjRuczcxNVoa6UyRRV?=
 =?us-ascii?Q?zYnhF3rDe91h6aKv0KbxOlLYg41s7fuNxDLLhLdRorOOGSXZsTlIfKZol2rf?=
 =?us-ascii?Q?Z2vHKRFDZSlb/i0V0GP+a4nd1DbIZMEYFIvGyf+/Xqlh7w0sXTz5q3S0N0N1?=
 =?us-ascii?Q?WBra93zptwX3d3pSAXzh/sHLWi2xZqTv6mAAsg4U8TeltTJHrNcz80nCqWSp?=
 =?us-ascii?Q?N3tJVV8x/2lG4BoeuWb/QRowLZ5pVxIXd/b48AH2iV6x9qf2SJQ2JoZFQIoG?=
 =?us-ascii?Q?c+TwsHfzNpkNVSuxRGk2NFIR+JWTU0GgES81nXR15ocHRYCz9VvveH8ITtUV?=
 =?us-ascii?Q?b7HKPn/xn6zS884ovWleePECpEZIS9LhMx8+83kyipYksXGSbHwaEtdGWVVM?=
 =?us-ascii?Q?MdPQM5I9CKuCYN8dC05Dw8pSszEh5rFgrkDu7rsPn6CUS+cHU2mOBTqQIvm4?=
 =?us-ascii?Q?olEC4Npn4IcCIOO3lpWtYkYplHxEmz8Ysl8J7SM9focTiAE8RJj6jhlMKg/n?=
 =?us-ascii?Q?sHzgZSfx6/LX7sB1N0gSe14h4+YY/xjMf+veBxfnEmOnXZ6VuXreHGAooyCn?=
 =?us-ascii?Q?5vNoYY+Jpihe+JnT667vb8sQ7Iw3s09iAnHfIAtonDfGvwEdjbeWlyGaUFCU?=
 =?us-ascii?Q?vlAz/PC7qeA0IBRgqw61ROW2w5RnrWqIH5SC0bk6T4curntwZbHZcfLdcawE?=
 =?us-ascii?Q?DQFPrd1YbluKSQii0WprvQU+4p8KnzyStAaXjHiLUBlHP7k4oUBEv3otAyMc?=
 =?us-ascii?Q?IywSZscW9eUE1YwcFAGVKl22o5NHWWW0WeW9RD8xWL6Wl7SPFSG00JWS5J5k?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <615A10DD7EF97B4F8FF91A5D7BC7E93E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J9DZF/BIQ1AxLeboX7PJbHmiNLRC5voGrcTRpEfFnZtVq/4AWyqikfGVvPOm4Wq9CxPHXdVBC7HHL72ZD+IOsJ0Ggb2uDp3ymXnoaeTzSvEX2crx2Tji1zE8IqJZgZzjFYrg6KTPgT6RS3zv7fqCkaVjmW7AvzXxyzmLWoLPcnnFNC6HXnvfHqDyHX1MpxvSt7+x3xeS+DHtVTvaprhGFTW6/7UH+CtVfjq46bmZgndzfZbwnBAr8Fuk3luYaVlya3N0qXEJQc2JNunzs39EcxnknpXND9fCJxaSze2kyLb/8hTHSyZ0TMN0tkuUkBBDxS9ij26/U+A0b8MSHqKooN75AqyiBUOOr4qoXpvmALDuCDPchvZaAm6em3NgrVLSX04R8aN1In4XU+79zBxmd3s/ofe46BvXTO21c0jbmGGvglqZN0knMfUgE4KdpwGP/3hUN5ZNivYyXR/a5psglICdlk88m9bJeEdX47+5QgyAfiq6wyy+lNRndGqFGP2tlOzKExnXuNwmy8wXe/920vn4lpdLovYlnXG8iqmvOdgiwV/Snn+MmOdqaL1UWBHFs+B0yH7BnsJiXgTp7zsZcW+wZWE5zOa9FFd5ny5A9NIxBZBDd5bwrkO1Qj7oWWpUCXKxTRjTgvbMOwa1chISxz8dz8E+5pqReBKmucgLJG69+0M2kPQhjQAtiB472LUGykSbIr+t1ejn08xcoT/Bk5Mak4z77slKebHTvm1mKvsYjTsF+Y/zo0hlaEoaQOGuZb+Vxzb0Vr8IONMUmp1yyoPsZmh7j31BnYqDuQHAh0p3bo1iUsMkt6SFs1uTtdc8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a8bd0-1082-4639-11ab-08db0e9e6747
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 15:16:10.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BYNoX64td3poYnaGKbWoM/LdYCTdLEHBsXOq8te1zvUMUil96PYl3vScr+0LV1yenHalGvNH41N2ojNuu5A0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=732 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140131
X-Proofpoint-GUID: ec6yX5V8dipmM2gk0ZAXA4BPfLQwfyYV
X-Proofpoint-ORIG-GUID: ec6yX5V8dipmM2gk0ZAXA4BPfLQwfyYV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2023, at 9:55 AM, Dan Carpenter <error27@gmail.com> wrote:
>=20
> On Tue, Feb 14, 2023 at 02:14:28PM +0000, Colin Ian King wrote:
>> The pointer dentry is assigned a value that is never read, the
>> assignment is redundant and can be removed.
>>=20
>> Cleans up clang-scan warning:
>> fs/nfsd/nfsctl.c:1231:2: warning: Value stored to 'dentry' is
>> never read [deadcode.DeadStores]
>>        dentry =3D ERR_PTR(ret);
>>=20
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>=20
> No need to initalized "int ret =3D -ENOMEM;" either.

Thanks for the report.

Both came in when I copied nfsd_mkdir. I'll clean them up.


--
Chuck Lever



