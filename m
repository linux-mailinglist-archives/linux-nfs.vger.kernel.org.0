Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB87B7130
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjJCSkt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 14:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjJCSks (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 14:40:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7090;
        Tue,  3 Oct 2023 11:40:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4A2S025017;
        Tue, 3 Oct 2023 18:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aDImBqT3y2BuYwZjckboYeATr6G+ZBw/VunCBaoFSX0=;
 b=WtDSUeU5c83bmr17AOHfIzqHB6yXd3pR54mNRVTDsM1F2SWIIMTX5nMG25HlQJe3nkm+
 81xV85AfHubKNcHJWh8VC7d7Ftj9zn5XH5sv+VseHKTTjhMYYsEv3W0A5edx4jMLF1E+
 x1uC+IiB7WDckt+iNV1h7r0blk9k65cCYGcYF5IKL86IQPIMMMQ/WwtzD7H15NlBy+Eg
 U7chQJG+++X1MFHPfoaC7tV+C5XO4IhEBDHdhLyfhsfo+WA1CvUixe4qAElvfKt2vUnM
 JN3aXUECC47RAy3WO6FLyL404f/hciHq+Lw77JDD8hKm/CVxMMPgqduvRJAU/mh6rGqE Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdwfa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:40:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393IA9MO002942;
        Tue, 3 Oct 2023 18:40:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46en7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPmovMcs3QmRqZQSmssk4FYwLpHg3W0O39Xr+TAlEANKLFbARAlWUxdAgKTnfwe0WSFNpLemb3B0tyYLHPd7LiV2JjRR9VdQMX55bRLshiahwlwB8bbMTaTi+OmlusdEkqsCj6WigsOxTKQSuyXI2ZqLKVpp/63XLPpoZhxLx/cmPGwAUq2CraW0qGYyjadgFkomCfenH6h8Yentrjapk/tl9z3k+8POmgla8KuoB0LlkjmXM1AgojtBDnObhNDbpc66VymVQ3i8LWIK51U8xOIvM+ohZEzXbpSIQ7Qq9GADRzju/mxl0ZJuaCU+dekMdjEgv4eiCvICG3jy7Hm0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDImBqT3y2BuYwZjckboYeATr6G+ZBw/VunCBaoFSX0=;
 b=lI9t21jKbNU+0ddVdWbkbzTbszb9auMlIwq7oxEu3Wst5/L68inQ6IrK/fpejicCf7jYkcrKzsf/cEJ5IHRzIDVsd6LnepNyX9klTygb1vxvfSPKO1zWq/mUe1GyeNmJ6dOYtKym2SwLBrwAc7hownTtGW0sYPG8l+9bI6MVkrda+trvTluwT9r+5AQdScfB3cG8BE8YSdFchhpPXYz8B4n4NOg1dqLl7IXhQJd4g6QL4SxCcJ9p5X8KR+zNmD6MkDnWIdEM33C6giWuVJylpsf4TG3ZAWXJrZqR8N3yfm9O56HNO4fYPrXjRlR5vG77QIEVdb0xIaJ0nYn2b0+WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDImBqT3y2BuYwZjckboYeATr6G+ZBw/VunCBaoFSX0=;
 b=bxKzorG5BqeRI+b4X+Cuh02v8W+2V4bMNsZZZs/zbfWqu85nDfRnK4AiWsoAfJzum932zPPR5UJh30xBAXwsFR+gGhudKmp0+/DKkwYDAcWhLnlUiYHNh7BIxPlIADMrYh1x0qBls28D1GW5hY6Jp8SDrO6lqVkpSweMp3PfbN8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6149.namprd10.prod.outlook.com (2603:10b6:8:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 3 Oct
 2023 18:40:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 18:40:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Thread-Topic: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Thread-Index: AQHZ5K6VS5KBJ72dikWpg4qvkMdvd7A4fEcAgAAMeAA=
Date:   Tue, 3 Oct 2023 18:40:29 +0000
Message-ID: <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
 <20231003105540.75a3e652@kernel.org>
In-Reply-To: <20231003105540.75a3e652@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6149:EE_
x-ms-office365-filtering-correlation-id: badbe99e-3b8f-49e7-b884-08dbc440377f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwrRM8rIKC60R+JApC07uCMOoZiPULYnrDMxiCopIuXmDDDgWNd/MyL2dW/P29So7nWcqCA9orLJztv/9VLWkKTNDb4lVuOcsg7bhF/GZU0cCSZsfuYYQ7HucNIxVYGj6g2zgPyVw3J+huXyy2BzmMKMw7lX+qgNn9OkRXmgrcwZt1/8y3t3ZxsNh+kTo1COMXLRi4AygE+ulSHD06Kq5jKS0+do5PbusblqWvzh0Zxk3h16PMnas3/LJbwc8+1BzCVeIL/UCUB6OdaJo27GY8uBNaK6fU0w27aFZU7XZss+Zj1Zu5d/a4x8YbdNzsTYciptW8HBIDRl68FPrcxDGO9+oAMzIaWswxifyeq8XwxPUecbIq6odPO6H3cQtRdRllWhrFp5w2PwY9dhzIHkHwOegCKDRLpCztBVdSaABNlH8EeGzW7KaQMI8Ff0BDBQkHk6W0wLrtFbWymgzcEMNt6bYEfxmb5uJp8SJi7s/v5wunMcfkoukwipGPW58ka5bW88O8eYdpHLbsGDjaQ2e+SPUOeuFZOe8k+m60DcF/i1NFd2bQNyKKEBq4rZzBB/4l7vSEKuyza9zdjJMsd1G+PJgVcj3AwqU45SrX/CbjVnFBkBuPqMM+INHypbEVVXAzfBV6NjH/YTQBdNRntlBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(64756008)(33656002)(36756003)(86362001)(2906002)(38070700005)(38100700002)(478600001)(6486002)(6512007)(8936002)(53546011)(2616005)(26005)(71200400001)(6506007)(54906003)(66946007)(66556008)(41300700001)(4326008)(8676002)(76116006)(66446008)(66476007)(122000001)(83380400001)(316002)(5660300002)(6916009)(966005)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJ+1Wxu60blucDxXxC6kPttNxr/7P06vzhmCABW84hFPa8RR8hWU4Bau9lrE?=
 =?us-ascii?Q?iRWEiL0O09inbmsGPN084grVXyWdn7dNWFNYTqG6yRsW2H5TvzB2RSRk+f4c?=
 =?us-ascii?Q?QjDtIhJ95oYH8rTavdky+l/417fGmW4uz6BUFZKbPwbd3IpcWFirDc7s2AuQ?=
 =?us-ascii?Q?7OSKqddRZliVYQnGCkAEE9RdOIEted4epcSKEG/MJ0v6YxyYKWSzkckgy+eM?=
 =?us-ascii?Q?ly10AND7c76SozUFU9Cb9VrR3jQWngQ1PIgQnGtYdMUgdwxB4kBkZVwN8uLZ?=
 =?us-ascii?Q?4auepgw4AqhCLFiLNAM3yzQdbyOIAf2kQmrh5RJyCSqG+Fl1mtTR4buburXo?=
 =?us-ascii?Q?mUM33M/eThOOp45SMd1W46Sos/T1kx99+1iR4bx9ZNrYNRR/Bpx8XHABxbIs?=
 =?us-ascii?Q?U5CgSrGCG0m6zZvs+B23bL7Vjp/Y8aulrOMia76YB9iZFQTavGnwlXxQjjjF?=
 =?us-ascii?Q?ZxZTEmr2rMfG9eVccZsMCe+VFORVxHmhRChtlkfhRrFEJB3A7vnsUxAy0Jyw?=
 =?us-ascii?Q?GNDN4V1wy8dfD+AqL+Ju93ru8/aKrIf0rJLD2seyGSR3SEPzAyw9HhZYKkik?=
 =?us-ascii?Q?QZHe2NNQcVN3K7eMpEmpA8A8qPca51fIv6EvQvq6lekHzxdi0L1XAPoTp9/B?=
 =?us-ascii?Q?kMHxXbVA/EpU/cVz4MHREGuBMHvux7/uHE4czdtKXWLgTQ9LaoZ5nuaKTFJg?=
 =?us-ascii?Q?DeZRxQXW7BA0dmIUO/Y15hUPBdlEGj+E/5mFLM5c7nMqPEys3tO+nf2XzIwk?=
 =?us-ascii?Q?04PBZpqdL4i0lnhjhb756CYG31RkvTR4E45rT3j7uqHq4KIPwgO69kmEsTlb?=
 =?us-ascii?Q?TFDxaBkfemNPwiTtYAKr7KvsqKxgbfOW9Vp/2akezXG0yKV+rpJWZgUcaLGY?=
 =?us-ascii?Q?pRNs2ADMP9icaBns+FMRHQZmJWH5JV0u4t+itjI6eYUkhP/935I7wrHZIuZL?=
 =?us-ascii?Q?OyeGCY8VSB6F3A8qORy456dHDMvwPbRlQdj7awAZvGOqaHZgELPo4z69ZCXg?=
 =?us-ascii?Q?EYmW0iiNSDVNiKQcvB4zvdFgvVUMnySSoEMrClr03OOXQhLusyZ3nz06ZP+0?=
 =?us-ascii?Q?s+CP4DuxnXKWlcDo9UGX8+jLV9iT6vXqNLizZc0SAgjhprsSqNi3Qg1G/DQK?=
 =?us-ascii?Q?IuY7uKzfXbM5Ow4bQWTwbfQjguVEHGkX64pp1pCO/rzdFiGtJiioDVzxR3Eh?=
 =?us-ascii?Q?Wdbtt/qgW1OPkYcxeJAzx/WpgJ3qYsvmvb3eAN45Q+Si7XgJgnUq9GXZsPgO?=
 =?us-ascii?Q?oEnJybX/8FRgQGgHBKOj/fZxice3PZXlcknRwVeJ4KK7Ht3Pimcr+pZlki9M?=
 =?us-ascii?Q?EZAcsPhAIfQRKgQO/bda1YdAzhoHON7YYq66o6dZl41owdCSBIWWKk38xPfw?=
 =?us-ascii?Q?Iea0TGrNqrewRxDRGx0sdG6FRD0mOZD8Dg5S/WqZIIfRp6i0mOoN+3Tpd1jX?=
 =?us-ascii?Q?zv6NScANUQM14aikl8eNDWxLe6lNYMxY3NogKvcebbw2F5CLg2l9Mqq1mg01?=
 =?us-ascii?Q?/tbT6U+1psAqYQ65xzmzu5ldMqo37yFcjk1UfviVqui5Z9YlzkFRRu1iuq7k?=
 =?us-ascii?Q?rfwFd0xDCB4n2n5ff22Ds2/+134FR/bB0MLHo5/EC6swVExn6ToHpLcM4jQJ?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDCD5BCFFF6D5B4E9895436177B412BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uzi6UQmdOoDR5PyifJFR2fnjnl4vogGf2evrFJntk9F1qObO2rCQGz9a74Na1jnCi3tPz3SET+ylDpw7cuWmitoAbkONGFQEKV3eo01gC3UhR9khfgOXlrH+Vo6wPmBc0hJGTAJu0rov/N1kLHplFBcRZyvv5T1si0BIY/9GqS2NqBIaSKni2VDAb2KDkZyeK9AlOjq74lxZ9wN8+/kqQLT1dWYyAhg0+tgvKOrYN9FHj2tzwE4mYZHLJLhNKYdvq7QGO7P8u6q6ed3wYqWGg2at00lPUc1IMXLL47rcVmsq/bfjFvT69lotiXO8nnEPDl3A5RDZQ24R6QnEWsaduSr2QBJrHxPLjvJ/V/Pqt5S5MOgA4anRj517GrrsIxoHMGzEMF512fYvsOXrnSloSZ4QaI95fs58ZYF/raVL37UyvuNv0EhtK7l1aKGHn4oXntKDpkDRKOp6sXfyCqTh9PzjrMngaKAE+1RX3k1MXwyhMFD0FZqpPOaKLLP6t7w/5OgbyXthiUSD2i2nzaZDY/fdY1wzdolQXYnsZRDr1SGM12KcN2m4/9uq8vSC5IdNbnUTeUMlwm7dy5AKeFpUfDJasdf74S1nkG4f1BvzFv+G1kbdWk+7qe5L5OOaUW0LTEv+w5TxGBdkS0KX4FW+VIE/ruVUYp0S7AavhdMP84A+10rHDrgO3uGuo7P4kmCk5+L+jqKP2DMZnQhL2cCXDUImUAd2SslCJpGAYbHzn3c/Jcq/InRgnF126b4INTBE1BtiCSZ0sBUndX44cuZXapXdOPLlZzN85DwB34Wbrdgf49itcBE9LA1JRK/MgdG9p7FfMdhu+m8WwmDwXuA9NA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badbe99e-3b8f-49e7-b884-08dbc440377f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 18:40:29.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4q57yh0p2b8h06DtHJ4f2kuU6SNH8s2CcOGxevYCZQGpECLFRBwrBbqgh39euCcsZeT1qUrIdRBapsD0sp22Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030140
X-Proofpoint-GUID: R_lMzFHgwbG0hl-kLUkDSD-_LHpEu67W
X-Proofpoint-ORIG-GUID: R_lMzFHgwbG0hl-kLUkDSD-_LHpEu67W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jakub-

> On Oct 3, 2023, at 1:55 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Mon, 11 Sep 2023 14:49:44 +0200 Lorenzo Bianconi wrote:
>> Introduce nfsd_server.yaml specs to generate uAPI and netlink
>> code for nfsd server.
>> Add rpc-status specs to define message reported by the nfsd server
>> dumping the pending RPC requests.
>=20
> Sorry for the delay, some minor "take it or leave it" nits below.
>=20
>> +doc:
>> +  nfsd server configuration over generic netlink.
>> +
>> +attribute-sets:
>> +  -
>> +    name: rpc-status-comp-op-attr
>> +    enum-name: nfsd-rpc-status-comp-attr
>> +    name-prefix: nfsd-attr-rpc-status-comp-
>> +    attributes:
>> +      -
>> +        name: unspec
>> +        type: unused
>> +        value: 0
>=20
> the unused attrs can usually be skipped, the specs now start with value
> of 1 by default. Same for the unused command.
>=20
>> +      -
>> +        name: dport
>> +        type: u16
>> +        byte-order: big-endian
>> +      -
>> +        name: compond-op
>> +        type: array-nest
>=20
> Avoid array-nests if you can, they are legacy (does this spec pass JSON
> schema validation?).
>=20
> There's only one attribute in the nest, can you use
>=20
> -=20
> name: op
> type: u32
> multi-attr: true
>=20
> ?

I've made similar modifications to Lorenzo's original
contribution. The current updated version of this spec
is here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-next&id=3D55f55c77f624066895470306898190f090e00cda


>> +        nested-attributes: rpc-status-comp-op-attr
>=20
>> +    -
>> +      name: rpc-status-get
>> +      doc: dump pending nfsd rpc
>> +      attribute-set: rpc-status-attr
>> +      dump:
>> +        pre: nfsd-server-nl-rpc-status-get-start
>> +        post: nfsd-server-nl-rpc-status-get-done
>=20
> No attributes listed? User space C codegen will need those to make
> sense of the commands.


--
Chuck Lever


