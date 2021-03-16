Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0D33D1C0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhCPKZk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 06:25:40 -0400
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:10464
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236569AbhCPKZT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Mar 2021 06:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+4pDQL130DN0M750tbjdh+XvA4IMiBLAQHYxH+XKEih5TI1+Q/N2cxypFWstphWA4cBh1sKilcM4OP2qZHFDug3zJf1K3ypo9DhTN70fsB2GRHsMxQS8lGq7GiHcuUdUGie+3SDNaoYGop1Pb4xRuHYOST9O3qY40hlGeuFKcP/oMzo/q7Lf0RND3I9a3QbBZVZybOXXhDMVy5JpSwnMWgiXamm5BmHfE9qXc3TsW8t1/UL+AezNhyPsjowrOPIy+0CxOTyiyWpPGTGvoPlYgrwphEWEdARoIZvTPXD16QVYkEFnwempqOdhDUTLW4PY58fCuZiQlpQ3BlNVFkISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++3AD+bMOpYxldmsoNg7Lmk2icQlsKnd+d/Hbrleo4U=;
 b=KHkipjuDccMcfiDxj4y5EAzpZgSvlpER9f/2LeJQPZs6x5muJCScrydFcoMJp4NNlzCDedQXGNhk4+4yEM1dXHQ8zY1LXR6IE/F4j3GL5eaj8OQ5T5ECleNyX+eHVxdRfOJlxvqwAbw5XLtAdVfCIgGIfVZJt0EeidXEshsZltU3TeyvCeq5O1myBfqrGpBPE/QdZ515ASotBRIawECKjGqbolqfJCZI1p2GptI+qqA2VhdFLCjbT/QR4RLGCpvUM6Gvr+v1+fpWN3OVgxceL6C3TmiKXMNad7wZtLLNaj6xpISgV5Q6JClZqHCO6nduphRUS01rKrfqEkd28Od7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++3AD+bMOpYxldmsoNg7Lmk2icQlsKnd+d/Hbrleo4U=;
 b=CZtACOU8iKbx6h3UpBpJjrFJsbZdvIKJUHXLmQ85ewloJdfvK+uYCsOF9aDLj2jpYC2rEyozojdGGOq93/nfrhDPF4/RfBd9/CjPCAqxucgk20k8kXsv8qXkhZ1I1LiBfhmx0svR/Ta4hXf9vXgVebCzx3xmTo3ZFTWOvWn6+Pw=
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM (2603:1096:802:20::18)
 by KL1P15301MB0341.APCP153.PROD.OUTLOOK.COM (2603:1096:820:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.5; Tue, 16 Mar
 2021 10:25:15 +0000
Received: from KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42]) by KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
 ([fe80::d8b8:963c:f1a8:fe42%2]) with mapi id 15.20.3977.005; Tue, 16 Mar 2021
 10:25:14 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH] nfs: Subsequent READDIR calls should carry non-zero
 cookieverifier
Thread-Topic: [PATCH] nfs: Subsequent READDIR calls should carry non-zero
 cookieverifier
Thread-Index: AdcaTmABw9JrWsV8R0CYehOiwIkkQg==
Date:   Tue, 16 Mar 2021 10:25:14 +0000
Message-ID: <KU1P153MB0197AE46D423F3AB32ADEF419E6B9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-16T10:25:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b07af76c-5f0d-4000-b64a-5283b13810a7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 401b2695-e0ee-4d06-6e24-08d8e865c9e7
x-ms-traffictypediagnostic: KL1P15301MB0341:
x-microsoft-antispam-prvs: <KL1P15301MB03411211DD7DDD12B2B7BA199E6B9@KL1P15301MB0341.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4thaYB9VCT9xIOmosvBtnqOqs9ReEvRGfTJon1TM1QP6xQtC2aywGAG0+By3aBzeqJYJIz1Zxif87BgDzqBhhz1DegDNxSIBQu/uqE/fb5yQgbP/v7+KoIKPvGds47R7xC2RkDLJ//KO+goRA3MhTxc4ZFIJYcXfsWVe7qV8/oa8V84ZECWvVFNzPcm9JbVxSUaEDMYEL345l6ZCeNopI+Xkpf25v+dOGZ0crknasUUg7FfzmqFIV7+zGxXvzW319R+3vFNR4ATs8TnfF46Ol+OUFOjbGaw7VI5IsVwRxrfqytcPNqDhZnbctgia+WEMq1cOJT75ScOsIUwZwiU+KuGciLCFUoaZa/9rWaQrHrvlmDGflBctDYAxQfDaoyOCOaf5XDo4z4Ho3pqJgqMUCjvW+p2V5ycZdhJET8+ogBiUNd5yBcGbksHeQsvV/cEaNiSs93YVzYdDSq9mLV6DqUpV+DOAvuETiRXc3i2A0fbZGVbYOx52uMcBLMb5Sk6vSLtfACVMV7eA+vT+8KfgFYIuG0nxFxdRnyyx4m4z1ELJib7rnV6kzLQVECsoUPJ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0197.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(4326008)(6916009)(52536014)(6506007)(7696005)(316002)(9686003)(55236004)(55016002)(71200400001)(5660300002)(33656002)(8990500004)(4744005)(2906002)(64756008)(86362001)(66476007)(10290500003)(66446008)(66556008)(66946007)(186003)(478600001)(54906003)(8936002)(26005)(76116006)(8676002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nQQ95Tiit5ejV3ycOQmhM5D+1qg5WD7YThroYi0XC8RTj90vcXJLrDKTvMdQ?=
 =?us-ascii?Q?t2rc8Los29ECwMNzKixpgBjkUuf5Y3x1V0snf29sHQz7oj8bE5O6F1C12nUS?=
 =?us-ascii?Q?3IrTW+ptC2xmnCqsPk4XAvxuyQulZQlPE4l9SA89TqxHl7d9qkAqJ9keNiu1?=
 =?us-ascii?Q?hgvqPAxazp4W2OhMx6O6fC3+8zRuOhiOPlN9opus+L1kc6AmKtVxWEGplpPg?=
 =?us-ascii?Q?DS2EQnCot7gs0h/JmCf8mIemp1a/7ByowWVc8cDWhQ8DVS+OUk0Kg+zYp38v?=
 =?us-ascii?Q?xRA40fm5ml+hUhTLK0fccC9ZgjJxsbsSilywW1KYMjxCq7zODoH3Uwkzecvw?=
 =?us-ascii?Q?f/YERT4vogsA84S92f87ok2CKfsebhqMub0QQcOIYOnbqDpflmUB4fGx0gic?=
 =?us-ascii?Q?umFVhHlsEvLAb8lzypCRAg7ysSLCfj3PVzP6CdQalQfJKOzz1FeinKza80W/?=
 =?us-ascii?Q?fTJpvHNffCtuSt7lxAfaEnxxcSjm2Ieu5/yz1Jwc6Xs3Z31mfWIbLNKRhDLj?=
 =?us-ascii?Q?Dc1ev8GA5eusneNaAl3HW2fsWtLmTarIUsXyvOvavm9Kf1Hh3YrkZ4JBjI+z?=
 =?us-ascii?Q?pBWn++SG8LfmzdS2GuTa6qbbj2moanOFGqi7SGgBRp4twy0AZ7s6n1CPZajR?=
 =?us-ascii?Q?RUB2gBqz/gZxWuxogK2rXjApvWeoLET0BKmv/YpZUFgPs9j+juZBLhh0kC9q?=
 =?us-ascii?Q?hi3D6y7aFNw3mTzaplMaossp7cj7jsF2h89HXdY+qD2Ti+AmHdE2OPCaC5xs?=
 =?us-ascii?Q?nbBhDZQ/eg/5jxJp3QmZWlYkGpqEeF1QeplIpvAYNqJFusm3Y9VFWUHoWT0X?=
 =?us-ascii?Q?g8z7EH57PJfZ90P4l/VOBXHrLyJN3rHE/VPg6oIIPzOhfh6dxKF02ird7oOW?=
 =?us-ascii?Q?vTdt9FrG1lKSg2GwK279NEvnXtL0kHmFoqvlu2xFbe7AMHKP1wqkYV1DiEa9?=
 =?us-ascii?Q?y5SYN92MBqljqpys6LQkZFWqmC4igHh/Z395iU2Bq1728UhZVNbk2dl+FyHA?=
 =?us-ascii?Q?E8s4k05G1GXoznc7IblsppnNvBZyMu02g4nzG9M8UhnPe8l7tBnCufznRDdU?=
 =?us-ascii?Q?b9gwZHjKPoUJ6aPCSWz3nqJ2VKTKldwywDOOlsPGhxqM/ZGU19ZUbvvOXFFN?=
 =?us-ascii?Q?2/A0mGvfY7ndzaptPEvMAzkAh7tCTOCTGHuNgJ+HBGYhvV0rvQ3py0Q4X1BC?=
 =?us-ascii?Q?zxzi5P+scHN8+SsTKc28JIAn7WddSWl0geTbTazXAY43iX7D6ZNvxgT74+fB?=
 =?us-ascii?Q?/CzcFOidVpM9fq5OWVfWamsI0pTPVx+o0dbhXnecg4cyhkbkxJ9bbg1ngzXN?=
 =?us-ascii?Q?d2+EamRfr6SfiiSkEPuanCpk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0197.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 401b2695-e0ee-4d06-6e24-08d8e865c9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 10:25:14.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtoD6npZhz8Dmf7RDRU4tOpWohnFWWIKQfM0N8P9lF5K+KipH1WOTHoZxG5agfDYc+1NjxxjScOVdlYnRKC7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0341
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Nagendra S Tomar <natomar@microsoft.com>

If the loop in nfs_readdir_xdr_to_array() runs more than once, subsequent
READDIR RPCs may wrongly carry a zero cookie verifier and non-zero cookie.
Make sure subsequent calls to READDIR carry the cookie verifier returned
by the first call.

Signed-off-by: Nagendra S Tomar <natomar@microsoft.com>
---
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index fc4f490f2d78..08a1e2e31d0b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -866,6 +866,8 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_=
descriptor *desc,
 			break;
 		}
=20
+		verf_arg =3D verf_res;
+
 		status =3D nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
 	} while (!status && nfs_readdir_page_needs_filling(page));
