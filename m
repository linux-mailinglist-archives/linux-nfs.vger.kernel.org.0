Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5F4AC498
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 17:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiBGP50 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 10:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355461AbiBGPt2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 10:49:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B8C0401C1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 07:49:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217Ddp0d004452;
        Mon, 7 Feb 2022 15:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LrHCWGwNqRr4OEqtQur7Ap2FhSVUScFvmzSuyVFhStA=;
 b=GcKUUJZDCC4caVBkXDdKIIcXbrATmhx1yJS5Hzjxt18PUf7Z9J0bFby/W1eEEB4qq2CC
 GGcvSlPsxIar8EKmIXWaKe4XvY5NhEWYJCPwNC9Z3Pond2ZfrKcpK8o15xMfAbkqS9q6
 Qsef9rxxT64HFoatjcBmlkiX1enORfxErxZuhA8FtM2rRcmvUmEL/w8EpPmsiLrKnho9
 e5GVV1zcn7Wffle9MlWag1XVT29fxvq/Qr6nUonZ46T98vAyuX1BqWeXPOAJz64QR3aO
 /FGjSe4OIxNT23lNkJdQB95PBYQcwJtFsipJie/y6r5Rt9m4SHEUI+h/46r6x6CXVqeq DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13pq0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 15:49:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Fl7Rn007856;
        Mon, 7 Feb 2022 15:49:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3e1jpnp80f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 15:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbmoR0Hwy2gXlPK1zXaCDhlacckeWeJI86GcXgZvQzNp+HWD19tpDrQ8RQERgK68Y2itj9Z/ZoIn1/Pqt7S1QCwc2LEz86LNa0Es9QlVgOOVOUYhR4JZiUZoK/Nn6uUa5EuPMujznbnUoYSIos0wlKEb72y90UE+lHxbPbaNARj6Kz0uYm53GmdhKXyg7l7Csj9rNDpVguWIXjt+QuajcDCF0L5qB4E/TeR2Afp00I+/FyoG1oKeFVtx7G+dWelkc1k3U2wIR60MxoEFirtx2EhX+7e3QOsNr5y7LX541nlkrsIN0CL4AHXN0wGbK+I+AiHPm4zDoXUFvbog598QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrHCWGwNqRr4OEqtQur7Ap2FhSVUScFvmzSuyVFhStA=;
 b=bxnIqC8n+yU7kFAwZgFPTpXf40rAWQLf8qzgfUbrAzh1+iDKOLGYVrcYrDjVdTVHG8awLIO+IHe7VyOAvmN5Nh93eqR+Dfqj1NmrkkYvv01XenmkXw4CLmy6jvnoHtcHg6/RCmbivrLlq2Cuj6GCm4Ukx9qyQFgaeWTuJ7vqHfpSK5jm9zLNOe7BVROzWk+ABSDNf8p+98ET6sZaxml5rwAm7ahmsNu1nV67q8zQL+vKUfYvCNdqyhfn438D/DhSJHhwm9foUCo31O+2kSluVQIujmcHYMm9A/wkuiGxC4kE2a8bxRbRj2wPVZMDbso5kLKRdA3d7TjrhxrlPKb7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrHCWGwNqRr4OEqtQur7Ap2FhSVUScFvmzSuyVFhStA=;
 b=sebq/0gTadYGql1Sr9G4zJfmxxjBpzptXrtf8kNEOntZeRt8DIlMteQHviGFQ075SqoKvDEplRgClwKNaxH3gR+vIadFjtGzZxY/cNAnc+Cgas0Y0zut4c6JVMAI+wlEHDt2CWBevrwHxuQu0X8FGz/ize49XYpOVlxxKJFiC/w=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MWHPR10MB1678.namprd10.prod.outlook.com (2603:10b6:301:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:49:18 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 15:49:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGbn3llxfcWCk+UU34Bdwb7RKyFReOAgAAYOYCAAsQQAIAAHReA
Date:   Mon, 7 Feb 2022 15:49:18 +0000
Message-ID: <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
In-Reply-To: <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 445cada2-aafb-4a71-adba-08d9ea5166de
x-ms-traffictypediagnostic: MWHPR10MB1678:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1678A9D8466FE2C0798A9341932C9@MWHPR10MB1678.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMkQLaIuHUBZuklJC9uYg7PNmc5iGAZVuMKSgURlousgJOXO4eHphprcJ3K2nGGqXTG6+orlZTHJ/htyIbI3mM4NYREtFJQIInhhhJtAvemz+wEttTbOoF2bVE1NNsUE75GTrdLiiyztjsx6ltr3+RQm37n7K1PiPK0D3mjS0hGLn9Uu2jwQDuhraw3u4zrREm6ApCuZMI5SxAg+b951w1nLfZ1guvRpvLxU37AhXdVSx9H2VEArUd/KV4vPRvcvQoZNsLcfetvINK6rlKMgBNBJwI17plD9cCgnOFwEXmdlNzkuBfMrmjzFgNaPPJuDWu0le2SqGQORh5+aIvhnLpS0GVoA5wD2C+62AxqZ1GujHBXWSekGRfjocDRCPQghjeacuLSeXdL1Mn4WzMfFhxwSFSmw7CmSrncd/OUm+xkYTnU9vFgVnF8fNWUMZGwxI3TUW0Z7mBLE/QSc2SQSeEKl1JnFGlp1tDoy2vM+zfwIk8UY/ooz//obpwwmfkL1xvKtZl6GjpwHhsbT6C+LqGQOPFt98MumT/up22/NX+rG9i5PVjMEjzbW+Xh4mVwa0D2qPlmhJ/LZ9WFV+WpwXP7BoVhcZm3aK8xlooNW3zRr4TXt8hf+vVAN4ImJ/MrM+p9nctL3RiemW5K++o56u2mkHWaj7YXmCT79SwN0YsZO8tzn4nbmFdIcpI2P39t3vPQGh60Fh6QGZuKxRu94GXcOYi8JXhyI5Sl26XDnsxXeEntFxixmYwl6kowvQjxC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(71200400001)(76116006)(6506007)(53546011)(6916009)(54906003)(8936002)(8676002)(4326008)(64756008)(86362001)(38070700005)(66476007)(66446008)(66946007)(66556008)(2616005)(508600001)(6512007)(6486002)(38100700002)(186003)(26005)(33656002)(36756003)(2906002)(83380400001)(5660300002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e/LNKoYkgvfCdBFIHmcljeDQ2ha7f3y+dzBQAGMvP/6/0Q5lV9bU3g8cjsvB?=
 =?us-ascii?Q?azrtRj61B4n0mIJZTSdMJCFDRLgoYI16Ml6mO7yJzoTH6/edyoz3HvIZ8Akq?=
 =?us-ascii?Q?BYwgkxexPyu4t4mtQJmNFiGW5l6tbp+502n3Nr0PqDRt9okfycoLRZutP22o?=
 =?us-ascii?Q?5hFdFbxljt+ApYDC+9lccdovA/4AlX+xoVMpkYX6ahQ99s6MBUeu7EZZ9cy3?=
 =?us-ascii?Q?jUJwxXoyQ8qVmSJTnkYe5Bn7H1GreIzd5eviRdX9aGzQ2UFouMfj0zB2TIFG?=
 =?us-ascii?Q?VKYmF2GgTbchuG8hp5CNice5c9ZoTPkX/vgRfZ820OvrKbi2RzgJS/RVdJBg?=
 =?us-ascii?Q?CIjoe0JPiHZMyJH0c25WGxEnPipIXEnIwRNq7CcZhBcRu26KPWAQ2FJccnBm?=
 =?us-ascii?Q?ABiAIPE88YsNIauKfVJja66WyQrru9XInC/cNI3ezBeUcx29RElsp7nKK5ub?=
 =?us-ascii?Q?UfNTdpqJ2LRs5mshth4CfpsdNox9q+EJZ7p9pf6JlZuboV18eunKKcG1xax7?=
 =?us-ascii?Q?l/MYGqBGv97jgu94D+nYA6Ik1y70uAAwlMXzcAtXvzkBdWn6/hpnfzRfs3P6?=
 =?us-ascii?Q?2W6vv7Gmf4Cy/Mp0Ono8M7mpN26h1Vu+rBpmuPHNSjtlamf2nfwcQttRQhO3?=
 =?us-ascii?Q?sDCtJCBSFxGMmEvrFlm+P+nGV1CWL7JIOju6gEq7SbrJVoLtg+zVue51avTf?=
 =?us-ascii?Q?U/25Yzv9DQIscyHaXnQxR/ZllkVGNNLagBvQAERPomX7H875+1fQIvfu2uSk?=
 =?us-ascii?Q?n+7VD4jtteBUUaMRbZWaOh7W1ipkuMl8eilnJhwkJSR+YZPb3W6ZTmFeLWAe?=
 =?us-ascii?Q?G8yMZTFMjSER6xOhJK16Djoi+GdjnDNe1LM73aFP9uu3j7/dG9sBoTv1AcFI?=
 =?us-ascii?Q?zgpt4VDJG7sqfoq+r+tM30f3cchoB6P354YAdHjy8C75YiF3/LwiDs/R57f2?=
 =?us-ascii?Q?TSwFevLytB13Bvoobadn2obPisEhFy9r97f2PE4bJ/O7XKixCKGFPToQVwAQ?=
 =?us-ascii?Q?IbAzlkwCh+crc3FLvbqBa5b+eph14wPZ1VFBdokNQajSffqFQlbVNeHJNU71?=
 =?us-ascii?Q?2lL5CXZXRNbp/JrULLJPBmiGOHQG6z1Yt6rHTHVRN7kZ+5Hbo0IPCSYGwVcS?=
 =?us-ascii?Q?9GMI/78nMihKKsadHRVOhPWIOpbIhC/A1kCq97Q7oheIxXo/JRYxNLL/P6AB?=
 =?us-ascii?Q?jatVpXkOJHQPX+yS0XFc6oknJJYHfgH0JgDp9cz7AHsMvNaGL4J2y2Y7hw3N?=
 =?us-ascii?Q?PXThtQTYdnHjKZD6pXu7MSiZziD4Yu0MSBX3cyQh32Vt5ngo6GFQWMxi8fRW?=
 =?us-ascii?Q?DFD9dpj50HBcQrhbhEaS2BbMVsesI/kk3TqpWMusZxXzW3SHjg84nxf+naTy?=
 =?us-ascii?Q?xuS8OHGN14fmtzBeQDmEcVsbvLenKxKO2Mp4CS7qycIZnZwmMnwR5ZYoX7UO?=
 =?us-ascii?Q?A+j+p/vHnPI/0UmExjU6b6zzIBHWyxg//LqPvAzuTQ8KxJNG2sZyJIz3y/8y?=
 =?us-ascii?Q?uGZD/zf//P+jFKGaZZcaZFBMPsiavsMuimkVIl9hRWqmuoq85bl7yU/Gt69k?=
 =?us-ascii?Q?piUsMgx0et3SisZB0INrIX+/figfKx/sgAh4EoEaoULFib5hsLmg8c0R45Px?=
 =?us-ascii?Q?CPBvX8Z9kwZpRK9wGJt03Fk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5ADC7902F12C144AB66CED42DDA110D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445cada2-aafb-4a71-adba-08d9ea5166de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:49:18.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DapsrRpE4puwen5VXMPPLCNHF0o9Qqy3VFArjvEJgAQ8WqSC+D+6aiXDwL0GL2xNWiZx0QfZ6LATYEJ87XcPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1678
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070101
X-Proofpoint-GUID: zNJVAX0orAnkLpudKy9Gt6kcii3frQwT
X-Proofpoint-ORIG-GUID: zNJVAX0orAnkLpudKy9Gt6kcii3frQwT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 7, 2022, at 9:05 AM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 5 Feb 2022, at 14:50, Benjamin Coddington wrote:
>=20
>> On 5 Feb 2022, at 13:24, Trond Myklebust wrote:
>>=20
>>> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington wrote:
>>>> Hi all,
>>>>=20
>>>> Is anyone using a udev(-like) implementation with
>>>> NETLINK_LISTEN_ALL_NSID?
>>>> It looks like that is at least necessary to allow the init namespaced
>>>> udev
>>>> to receive notifications on /sys/fs/nfs/net/nfs_client/identifier,
>>>> which
>>>> would be a pre-req to automatically uniquify in containers.
>>>>=20
>>>> I'md interested since it will inform whether I need to send patches
>>>> to
>>>> systemd's udev, and potentially open the can of worms over there.=20
>>>> Yet its
>>>> not yet clear to me how an init namespaced udev process can write to
>>>> a netns
>>>> sysfs path.
>>>>=20
>>>> Another option might be to create yet another daemon/tool that would
>>>> listen
>>>> specifically for these notifications.  Ugh.
>>>>=20
>>>> Ben
>>>>=20
>>>=20
>>> I don't understand. Why do you need a new daemon/tool?
>=20
> Because what we've got only works for the init namespace.
>=20
> Udev won't get kobject notifications because its not using
> NETLINK_LISTEN_ALL_NSIDs.
>=20
> We need to figure out if we want:
>=20
> 1) the init namespace udevd to handle all client_id uniquifiers
> 2) we expect network namespaces to run their own udevd
> 3) or both.
>=20
> I think 2 violates "least surprise", and 3 might not be something anyone
> ever wants.  If they do, we can fix it at that point.
>=20
> So to make 1 work, we can try to change udevd, or maybe just hacking abou=
t
> with nfs_netns_object_child_ns_type will be sufficient.

I agree that 1 seems like the preferred approach, though
I don't have a technical suggestion at this point.

Again, thank you for drilling into this.


--
Chuck Lever



