Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD43D349650
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCYQDf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 12:03:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhCYQDQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 12:03:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PFtdiP051577;
        Thu, 25 Mar 2021 16:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vMGMD/RngKNdbsXzjB8SqejljzbS5pnT5unCkx44s/E=;
 b=bLdDWssvnuJagRlDDObCXvP9+W2EtCoTVkikmaAG575ecd+XnWuqqTaQ7qPLaChBubWX
 L6FZCJ5gIDGg1FVaUy4pKXExoAj1l9tGn4AwklXwE/FRkOTWF34i73OMA/oklzngOO5T
 ke3W1zTSD3cVhg7+ikN2oCkd3ZMRoPGqWA5+nJSwQDYymF0zOtsh1BfDwz8aor8tUxdL
 bLeW5B47LfVzy8F0GbU9wTZvPx+Zb+wZpD/8oh3Osc7IlFju55eGtE6+G4nWHIbqOKhD
 6LtDLbtqHhg87n/yE7yarpAxIfoxEQGUwbiTh+oVZ8gibu6r1RfFu+SguIN7pdrZiLKb 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37d90mpthc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 16:03:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PG0J2O041393;
        Thu, 25 Mar 2021 16:03:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 37dttuuv1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 16:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvjfwGkcKES5NU2nEyisuEhkHqZQNucpASq8En6QALxjO8HyvCH6ptWfocX0tZXBBqSmrXVmDuHSQTGSM0knGidLAtT++6jbfB1sFeHZ2omNVXgeP/D7JjibuPRF61MPeayN7B14jDH/2LVxP9FHF645l7l/SYoZU/djNI7X1KnC4JyFrFcaVqSh19XyIz7+7HRGNEChGKvLfwqBYZVBnntS7rgHbrpKYEJTlDfpZcCiUr/vcyoWmlGjG95OvRCYo7vD8Q++Q1cTWXodCMKXbRJci/+E2IiKk4VA49JsJOxE3AZicQZnjlrLbRxWi1Gts3go/NDVm2UPHB0jQH+Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMGMD/RngKNdbsXzjB8SqejljzbS5pnT5unCkx44s/E=;
 b=IudbHMw5BtDm1emkBCv6gtDY/SiBvQdlwotD7cUbzRtHuE1jKzHZ97RzBFaZgUqn81FIWGogz8vFi3gKRsRWi4dS2o1S46jcF445ZAwIt0E9QwHT61XxHJH4EQKcwqsDmBbPn1thMvYA7r7CD3/3h7ve28mOQ/0XV5pfnMnRFLNT8DVlTvu9WAHpj4/N8FbD8xFBM0eVk3wj+PfC4rfq05rUAQ42VVerZ2xl/WBaHoCGOJHWIy+Z/BEla7zRGtKHJNFLu+DXGjUYljz+rnRqRUHk3Sdzp7rFif0M8FTaqxZ4i6gPvt9jOFLm5mnfN+5OC9oVMO13Q/oT7OqirnM5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMGMD/RngKNdbsXzjB8SqejljzbS5pnT5unCkx44s/E=;
 b=CyMAKFuP4baqAemq3xfFJBK6oHidEFkOHA9GeR665ztxFDC5JYizxqvrUjIq6yRsbR5LlvvtEkKdzQI/LV/xZer3+1wo3JaNVg+dZCPAnTkY0w4PgrKU2BbAWAmRFdnoUjo83ZYuNU5wPGOBS/HABt/B8HcqY1tpRCDakLT+aG8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 16:03:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 16:03:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v3 0/5] SUNRPC: Create sysfs files for changing
 IP address
Thread-Topic: [EXTERNAL] [PATCH v3 0/5] SUNRPC: Create sysfs files for
 changing IP address
Thread-Index: AQHXIZBVLVquEkVXvE+nUFCuYvpQ/Q==
Date:   Thu, 25 Mar 2021 16:03:01 +0000
Message-ID: <FCA81F8D-9CB6-4085-AE08-AF5ADE4F915B@oracle.com>
References: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CAN-5tyFLha3Wvy6m12S=9m+Yu0pg5wtEn_+4=aadXzECwBzoWA@mail.gmail.com>
 <SG2P153MB0361BA94D52E1123DEE7E1EC9E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CAFX2JfkH2c0jXHQnKezfcCFs9rwNVhnTtg+8pOtTZbLyKU7VBw@mail.gmail.com>
 <SG2P153MB036155B6E43C625295AEBDC19E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB036155B6E43C625295AEBDC19E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ee8b13-b5d6-406a-1dc8-08d8efa777af
x-ms-traffictypediagnostic: BY5PR10MB4387:
x-microsoft-antispam-prvs: <BY5PR10MB43872A68F00D47E911B5ED1493629@BY5PR10MB4387.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rq8qXkHSxarIju5/llujeIHZ0fZBS5hEl0kOsnjsNZ485O6t2J2QONJIeXXScYFkCI5rD3nwqj1SJw0z593tjVGF0FhUxI78J2Ue/jWOZ/Muoqcl5/fuyQoMkzaUMDva8ZGwmixnfMo0wC5MefavpDWWsYo/4C3rUZJGrGA/vJxaDzAQ92DlD+udQKxoOIFsKI1gMEFRixMLBVJV1f1LaIgWVTN+3ZnKFt4QDKkzrGfUfHd+0oa6TwiRrJlIOSSxFD3FtqQ7iPJ40yofzPd6f/I4OgIwAttQZZortyFAPWyivr7AP6shPwGrM6VeXTZetUOJvHqJaSeXbdbOPnpcwiSUMGzTDa/MPIKA6HnMMHuPjirDnuIuNOnJRwxgpCnGTDAlXqOLpVLFbxEh7eaXooBUhF0f98IcRAM3eEHmWm5/RRSBnDgS8yy1o9l/2IYlLHRQO/eLRgP9bDMGRpHledLN9jIx7vNFp4S0Rqn1ITsKy8T/+omAebsFfwkBPZX9tiOfwz5y5hFzj9ste4azCMX72AvaYELPqD57GJVvsOm/C2TWazAGc6guRVm4LqHfSJ30hjK3LwW3NeuxGYVI/behWkWM5GPC1rO9USAQAN27lsiKfCh9iHvcK0jLdnp0k3EGcuPKhMdjh4eEGQZjO0If2e7OObjCfrPLSgtKvZTOoA8ZXkW41G7Ce+/yeKHb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(53546011)(478600001)(6486002)(71200400001)(186003)(54906003)(6916009)(26005)(316002)(6512007)(4326008)(2906002)(6506007)(2616005)(33656002)(38100700001)(66476007)(91956017)(66556008)(66446008)(64756008)(86362001)(76116006)(66946007)(5660300002)(8676002)(36756003)(83380400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+F6EoXxSs9YI4hgu1AGbdVYrzHmab94bpIbOp6/zvtf8hGEGGbb3h15Uz7Y0?=
 =?us-ascii?Q?xZLr3+RUtdymBJmanbKm4fDgJD8XykmTpf98WWK5I16+3aru1ywIJNmUnjAr?=
 =?us-ascii?Q?BgIpgRUi3EcVbwMw+vc8L0YoFsEJ+mvY+QTrDpjWK/1JiUgafHYB/5ztIbyS?=
 =?us-ascii?Q?FfY26LoIOj5EGdpafnscxtnJ/myHxnXbBJK/981isvTp7a4qC8l4+iyvp3AB?=
 =?us-ascii?Q?gPUfMvEgSEa5GEJXgrQBUM8iTWplQOkBOhDHDNJQ6GtkgwsG2LQqBzW6ECDg?=
 =?us-ascii?Q?FQlH262oBUU87OQ6L1vFcXW/bcuGP/PFvGI49ITSOOighPw2knxWVVUM5v1R?=
 =?us-ascii?Q?9/yiRgxmD7diLNv5jr4NeNzBGWW0Ojv3CfPGn7DInHM8g1GI6m5lkxFaZCEL?=
 =?us-ascii?Q?vAG1Q0/Lf724UGFY0eIbHECoGi6FOwiI1wQx/cxhvcnsWlkR2Oguj9DV/zcq?=
 =?us-ascii?Q?DVXtnbb3kGGuYQyLx3QAJOPhVdsyLpSPsXc+7LXqPKhbbR/T2YkGlrYJNdUv?=
 =?us-ascii?Q?S0RGqtBKAllkMX3Sst3BsLmb5byOiM3e0WARbnw9hfWUFEB9CMIRe4EtFn89?=
 =?us-ascii?Q?qnsJj+LCP1USIrrM9/Jm4jlKK5Ojxaw2JDAbXuGVkAyj5dzlVdEIkIhuocrZ?=
 =?us-ascii?Q?Lc66k2WI9qF15J0JGAIW9DnblhW7frOsiJL/QPzBoao9XgDbtCL02mA4m6qa?=
 =?us-ascii?Q?tLPBUJvVbpBAPtxlrHzW0v9Rt7MHFWsk4xLkQlQ5uyP8LBevCfzV4wWGYrxT?=
 =?us-ascii?Q?QF4PNO9q7m2v1NLSvQ+9Qg3yBxUVaIHQNlLCoXuhmTRo09QzUhjQX6LV87/U?=
 =?us-ascii?Q?zjRoQoLlPun0x0rCN/T5haBFwjAdMn0TM5WiWZ5rproWKRPI1FHIGTnqW/3T?=
 =?us-ascii?Q?3Qn4H+XIcycYryHn3imf+znEciRwEZyCqRd8eogA+q3A4HBAGGD/AkrNEtBl?=
 =?us-ascii?Q?d967fzH5vZtx+XYdhEQKYKZGU2NP1H41gWb8OXaN79dtAea6wbCdFNovgBsE?=
 =?us-ascii?Q?vv38pO+H28aU04aApBcDhDGY8P0n0vP2Et57oIXrqW3JeKmqw7thTuM+hNcA?=
 =?us-ascii?Q?06zvlo01iFw6731HmXmoHSigrwp0379dYRgImj+8QgHTgXS09v/KGjIs1RvI?=
 =?us-ascii?Q?r/GdOY48T2WS/k0LnXvGu3pHgFf4E2473xo+iwQnqhJQ+C4uzTRRV1OB1hqX?=
 =?us-ascii?Q?KmMtmrqLk5Z2D4Dl2zwNN4FoGqPcNgpMwahhD8kQpc9zlMY52+tE/6D2oWJi?=
 =?us-ascii?Q?cEH/aypBvmRyuOlkLdmuKql+xBmAwUtxloHCWXq89fNOprX/2icbqeYpCu3z?=
 =?us-ascii?Q?rEs6sooMVirdv5+CcOkORoky?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99D007E0F312C84AA102F07CEA65C9DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ee8b13-b5d6-406a-1dc8-08d8efa777af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 16:03:01.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R4CSEvWEou9WvIUMDJeetUs99nHlHBC4vbvZmlBmTVDLwZ1IBbY2mf73EE1CU+N1xZo5rPz7u61zyL/IK1s7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250113
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 25, 2021, at 11:03 AM, Nagendra Tomar <Nagendra.Tomar@microsoft.co=
m> wrote:
>=20
>> I've been thinking of the write-to-sysfs approach as just the kernel
>> interface. I would expect there to be some future userspace tool built
>> on the sysfs files that is easier for admins to use. This future tool
>> could probably be coded to handle dns resolutions and write the result
>> to the sysfs file.
>=20
> Yeah, I got the idea. I was hoping to avoid any additional userspace tool=
.
> IIUC the userspace tool would be more like an always-running program that=
=20
> periodically does the name resolution and updates the sysfs xprt addr
> file. It can be done using mount helpers which take the NFS server's host=
name
> and start the process to periodically resolve the hostname and write to s=
ysfs.
> Then on unmount the program has to be stopped.

Well there are variations on this idea. One variation might be
a single orchestrator daemon that would manage the sysfs files
using inotify, so it wouldn't have to track the operation of
mount/umount.

The sysfs files are meant to be only a conduit. User space is
meant to dynamically provide settings based on policy. The
opportunity here is to make this something that can be active
and rules-based instead of a static configuration (ie, more
like udev and less like /etc/fstab).

And note that any solution has to be container-aware. mount
certainly is, and that's another reason why the DNS query is
done at that time. An upcall would have to be done in the same
namespace(s) as the mount was done.

(I'm not advocating any particular approach, merely pointing
out some things that need consideration).


> With the dns resolution upcall on reconnect, all of this could be avoided=
.
> Infact as Olga said, if we extend your patch to treat hostnames specially=
 -=20
> do dns resolution upcall if the sysfs has the hostname instead of IP addr=
ess,
> that will serve my usecase well too.
>=20
> Thanks,
> Tomar

--
Chuck Lever



