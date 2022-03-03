Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA4CC200
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Mar 2022 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiCCPyu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 10:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiCCPyr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 10:54:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0D15F091
        for <linux-nfs@vger.kernel.org>; Thu,  3 Mar 2022 07:53:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223FCrsh007695;
        Thu, 3 Mar 2022 15:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HPbg0Js+wGRsxgodkhAu8yxEFzj3dohXjPhcDyFnrOk=;
 b=Ez0BNLBnsSW2jjx9iU+u3LVrcZUktbQ4/i1CilgW4mJSZ8kr4QlspUj6qK6U1IvMog5r
 jm0K0tHAW7vZImVADqpQ02YpQfQicRCyRAtekrpqnKHtuPeh/KnGYiGsYdexTxLX+9Cd
 EpRf7G4EygOsVSzuXFmCOXh4y9jXyf+121Givm/0+tHTSXIOaI8LM5twNuLCsORY9Ynm
 eHafaIUrQV8oIdC9MKgb/neo3dO+asHuAFuiZ8w390+Wnzd9P2OKW3E6jPMwqFmpDhXq
 JBPKElaJe3SkYNMUSqfseP+x5UmT48Ye2Ld6tKfnNi3ThoI8Wj1CLHhNEl4PuzG6Ki/F Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15aryn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 15:53:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223FowZ4050417;
        Thu, 3 Mar 2022 15:53:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3efc18wtrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 15:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb90zGGXFDVW25lhNEtRQySMDfSp+2FtKFYyZ6k6jU1emeWNB2j52QZlJeKWfHjctVgkNLNS7Bb7EO7EzrIwVtGgQx48fS37i5L/M/grK0CQjNwHfCMJ6d/gUWsyBGZPpHSiWxmo01za1fiKxSNwQe+gFcg92SFoR8ipnQ1qLiuXviSyLJITQwPFvmvAlcSgllGeKRY95HkHrVOrAWlERX30sHkxXNypn+ShdbYb45AOW7PkHGd+Ms8ZyK3x5sLPijlatnBeWl/3BPyKJ6FK5YiuO91ZvcTYvGpCsET82RDUaB/1O4NsMOnkDwbxPqj3NoOmENkftV2mrBLuV+fk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPbg0Js+wGRsxgodkhAu8yxEFzj3dohXjPhcDyFnrOk=;
 b=M/zh2ybqFwaMG9+g+wZHlyf9SCiikcMp3VTYQWf+Yn0D6syJml0wDOrL9VadLrZ2jNbYbX6vQYQ3rQN6tDAVFVpK1J1C0wZVOoSiGWiZwKJg7wiFIeTsy6r6py8efFhrkjKlQ6LJ4/6znAUkLWCsIeKBSOr4dJPvHcCRiVb2OtYxCSzM+6wmHQcScIxhU4faGQ/t3bJONN+/NIH5tf4Iym1A2YI5+z5kl+1nmVcd2BrfVwF7mb1T0HrLvPNh/HaTzgRw0FlK7v94lytPE+5KBbsL3SBErwjY6ojkgQSY/Ey9fAWSm9LnctCwZls3CbyF9dmv3fqndXCu0LDvwS1SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPbg0Js+wGRsxgodkhAu8yxEFzj3dohXjPhcDyFnrOk=;
 b=ZPXZVIc2wtrRjb2VG9AzIoRmIKaqPOXeJm9stq1mqJkQYIlX24++jmsOKjcY52nng5qoC740edvUmjTIG9Guic+rRTDjLGT8ASgBXZjTafC0UaO/mcwBEgw5VH+MZpHhGCH6hZzfY6H29HcbyOeF67eIkyn8hjN0fta2qrPgohc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 15:53:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 15:53:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6czeCutPWqYkWZgIa/iwKGvKyqohqAgAJglgCAANDQAA==
Date:   Thu, 3 Mar 2022 15:53:49 +0000
Message-ID: <1872EF26-5C7D-4C5D-A425-11548477BAA6@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>
In-Reply-To: <164627798608.17899.14049799069550646947@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1af005bb-4720-4dec-1b86-08d9fd2e0217
x-ms-traffictypediagnostic: DM6PR10MB4124:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4124D9EC70AAFFE07FC1CD7593049@DM6PR10MB4124.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ackAK3uzA35vAIgWLJVpHHohR+WqNZ/8JRQg00FcwnGBgRYlxXL2diG8WscZK3qxjPQxZ4eFrJXVBg43bu7wXEgta+DDhjavC7k8WwIYTqKIcnveu9Ei9LUNxsCLlLM8Z3vtcESup9ctds6QzFX8pJTd22235MaK+hNWql7bMUOv21G24AJjSI/M8AsyT6Hb8rQwDVBEV7eH1Tck+QRwNeF8bWi5FcRCdGtTsflAGwkk6dxYhoi3yVVRXICMJ/KRBNWW1TxZGr9vUd26kuP64n/Z8eq7HpR63r4o9ZB2meTEergQqQLDOJiqOb70uoYwrcOLihuWb0GvM1TCdwwZajIdHx5HGzX6p9in2r5NMcR4obaK+qGSXzLUdnRkfP5mVTIBd/6OoZaXiUAl+JQ1dsqsz+3f1kO6mdDXO/mN41uFl+eIWPP/0+wVlTotwD5hMMu+d7Ur9HLt8tdSeLP9BHehM6yPyKaSDY4Fph22AcyBa6xvMP60ULbK+kSEB5AAQ5K9roV0e1beTuyC2mR0jrtfyzKhWJQiltLsIRP76LEgaQXlkPHpo8g7YUYu102j+W56PHevS8OIWaMOrazVvCVnti6aY6DS6lkN5eVITo5yyoTh+zPG02QYSWr7qMw/wggFYgjNES+vGjs7uMy72LJpGAs7IdPa61V2rNx8q1yD/JoKp0XhmI5HsXxziuHyk4EEthzxMcdeAvbLkaYtNp3OgZu835btud9CsCGV+AywVx3pAsU26qOTdrLLYo90
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(54906003)(6916009)(53546011)(38100700002)(6506007)(122000001)(91956017)(8936002)(76116006)(30864003)(64756008)(66476007)(66556008)(4326008)(66946007)(86362001)(66446008)(8676002)(6486002)(186003)(316002)(26005)(2906002)(2616005)(6512007)(5660300002)(33656002)(36756003)(508600001)(71200400001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0EfJKbnNdkWYRVq9gPhDM10kyCbsi02CCtPS9/HXFwbiiOWxaQP2/x8EqOuT?=
 =?us-ascii?Q?QtAiQUWjIhdaa0VfTITtf+iVwuk4iLUB27Xso4oVnYDN5SsVXmQCB/6rOkqj?=
 =?us-ascii?Q?ibzVgfdsNz65I/dQF+DhVsn6jUq+Q7p+J5n33LT+ib0AvhbxhOHKk8TP0Xb2?=
 =?us-ascii?Q?zxvRZhAp1KtxitXsK60mBJLeGFW5+dd99GyIbPlx7E0ziQSZAt6QnqaLhffo?=
 =?us-ascii?Q?v1bUmI+IvJFUZIfdNlUY+L2YbZhGVX/NBi4ikKcwYXVUzxowuHtB2leiAKy4?=
 =?us-ascii?Q?r/cjGnaKtgGMFw6MPojyfYUeELWYemm3hpzCD2idWb45khZ5HlBdJu3aCqpp?=
 =?us-ascii?Q?exAM01UObiInIjJ50WbZa3u/GIJSS+uZa7T19owgpKdB/t1nb5s1eXihVTSq?=
 =?us-ascii?Q?tYnrhl1yj+CEXu+WUn0idtDaE8uNE6fUtAglTocfH/RkG00e/9HJy4fpkt7r?=
 =?us-ascii?Q?3tgLFCH9NFMoutC+zSPyo5OjWDaiaRY6hV9QTEYx+NKua5Ekl5QG9CO30dQr?=
 =?us-ascii?Q?FelGWxT4EabOHpDhz2wqJJ3147rpo1CgLmLORgNC9ENU/EaIdSt/SBaFDaCQ?=
 =?us-ascii?Q?ycw0FwMCqpgn6qXIVBidnAjz09XfObni2O4+Gq5mZjosFNLk5kbVcXSDJ2XO?=
 =?us-ascii?Q?WbQflT12kn8BW/QJPkeQ9G/m+BilE5fet0v8XzJMYGlVIF2SAXgVRxTZ1uP3?=
 =?us-ascii?Q?LiVslW7oSPuwlXf+w93rBwkm+IWmWeBQoJGhfhCL8fHZqERX0LgrkykKzWX0?=
 =?us-ascii?Q?js5gDzA4HgygKkvFJkWGBq/3SwRMc/Tekb7lDgQ46pnxf8TjUY3ovNExHdok?=
 =?us-ascii?Q?zvqX907kZXphs7phg5Enpi6P8xVcwa+aB2d8mdWPbyQbfcLpfF5oH3pnCkwG?=
 =?us-ascii?Q?shymLB5BUUM5kfecLHNkwk01il7/Fqek3SM2lsL5NyR+g1zZ1FAZG26H8kKk?=
 =?us-ascii?Q?gnqyYBOqKPCtH7qLo71jcnu3r9sB52BA2pCnoaWLAZXIwnIZG+JXp1rppjxW?=
 =?us-ascii?Q?sVC2Tz9mMTA0PifNp4V3oIGN0LhZLKbi3Aju1XxsI9FuNMzyyxLNtvCCSkGo?=
 =?us-ascii?Q?jbDaiK/RTGznstN79o633cquGYGedfpuw/qOjlkD9+L3cRRg2zMmVt3fYEQr?=
 =?us-ascii?Q?UxGoE2UrKfrJafSjrnZT4tJiSh9ykExn//fD0GHB6aTUPAZkDLNNcZmhB20e?=
 =?us-ascii?Q?DbgTGjFLQKppEA9jn235m+yElIixC/QPojE81kn+/a76Jb9TPGRWr+iWf6og?=
 =?us-ascii?Q?GlYYCJ7PbmBT3UsNscA4pkgDaLRSuA45lBggw/M+dX12cXV0fmh4yrK0YkB6?=
 =?us-ascii?Q?+uCp5t/sRLQYv+TgekzolkDzitSAB+Q46HTPb7ZV7zVlVE68ARgn/xYaRcZb?=
 =?us-ascii?Q?JYgP5XIJYECxa79nqiaTyCDlC2bpjz3y4itCsfzBADaGMYdy8ulRArn4+8UO?=
 =?us-ascii?Q?fdApLghREfZFna2C/t0PBZNMCd17AcYMsuquoCa4epIBuR568lsXymeiz/n2?=
 =?us-ascii?Q?+GAhhtP1R1tWJqVdBISnCEy1pzlEopB/Q6nJ5tlmUqS+vQiNlzH95XScS8iY?=
 =?us-ascii?Q?pUNNJyqSds93dgvKKkWsYp1oc7xHf95VJ6xFbMOLetWgs5JaSEQ1aZUah5yr?=
 =?us-ascii?Q?1a2cFuslXXQ0tqyDfco74CU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C8FCD903C0C4B4C8A11ED3B9D068088@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af005bb-4720-4dec-1b86-08d9fd2e0217
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:53:49.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jX0ShA8KTn/tYMCMGe3s1nydpvZQvNl0V+M6FlJ27dg0d1pSTxqyZ7gbR+6zztdhsGHkDrl2lHa6Ywc+AfquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030076
X-Proofpoint-ORIG-GUID: F1ZsprTvPLh6nmb0HCTiptbKJudm1mpz
X-Proofpoint-GUID: F1ZsprTvPLh6nmb0HCTiptbKJudm1mpz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2022, at 10:26 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 02 Mar 2022, Chuck Lever III wrote:
>>=20
>>> On Feb 28, 2022, at 10:43 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>>=20
>>> When mounting NFS filesystems in a network namespace using v4, some car=
e
>>> must be taken to ensure a unique and stable client identity.
>>> Add documentation explaining the requirements for container managers.
>>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>=20
>>> NOTE I originally suggested using uuidgen to generate a uuid from a
>>> container name.  I've changed it to use the name as-is because I cannot
>>> see a justification for using a uuid - though I think that was suggeste=
d
>>> somewhere in the discussion.
>>> If someone would like to provide that justification, I'm happy to
>>> include it in the document.
>>>=20
>>> Thanks,
>>> NeilBrown
>>>=20
>>>=20
>>> utils/mount/nfs.man | 63 +++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 63 insertions(+)
>>>=20
>>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>>> index d9f34df36b42..4ab76fb2df91 100644
>>> --- a/utils/mount/nfs.man
>>> +++ b/utils/mount/nfs.man
>>> @@ -1844,6 +1844,69 @@ export pathname, but not both, during a remount.=
  For example,
>>> merges the mount option
>>> .B ro
>>> with the mount options already saved on disk for the NFS server mounted=
 at /mnt.
>>> +.SH "NFS IN A CONTAINER"
>>=20
>> To be clear, this explanation is about the operation of the
>> Linux NFS client in a container environment. The server has
>> different needs that do not appear to be addressed here.
>> The section title should be clear that this information
>> pertains to the client.
>=20
> The whole man page is only about the client, but I agree that clarity is
> best.  I've changed the section heading to
>=20
>    NFS MOUNTS IN A CONTAINER

Actually I've rethought this.

I think the central point of this text needs to be how
the client uniquifier works. It needs to work this way
for all client deployments, whether containerized or not.

There are some important variations that can be called out:

1. Containers (or virtualized clients)

When multiple NFS clients run on the same physical host.


2. NAT

NAT hasn't been mentioned before, but it is a common
deployment scenario where multiple clients can have the
same hostname and local IP address (a private address such
as 192.168.0.55) but the clients all access the same NFS
server.


3. NFSROOT

Where the uniquifier has to be provided on the boot
command line and can't be persisted locally on the
client.


>>> +When NFS is used to mount filesystems in a container, and specifically
>>> +in a separate network name-space, these mounts are treated as quite
>>> +separate from any mounts in a different container or not in a
>>> +container (i.e. in a different network name-space).
>>=20
>> It might be helpful to provide an introductory explanation of
>> how mount works in general in a namespaced environment. There
>> might already be one somewhere. The above text needs to be
>> clear that we are not discussing the mount namespace.
>=20
> Mount namespaces are completely irrelevant for this discussion.

Agreed, mount namespaces are irrelevant to this discussion.


> This is "specifically" about "network name-spaces" a I wrote.
> Do I need to say more than that?
> Maybe a sentence "Mount namespaces are not relevant" ??

I would say by way of introduction that "An NFS mount,
unlike a local filesystem mount, exists in both a mount
namespace and a network namespace", then continue with
"this is specifically about network namespaces."


>>> +.P
>>> +In the NFSv4 protocol, each client must have a unique identifier.
>>=20
>> ... each client must have a persistent and globally unique
>> identifier.
>=20
> I dispute "globally".  The id only needs to be unique among clients of
> a given NFS server.

Practically speaking, that is correct in a limited sense.

However there is no limit on the use of a laptop (ie, a
physically portable client) to access any NFS server that
is local to it. We have no control over how clients are
physically deployed.

A public NFS server is going to see a vast cohort of
clients, all of which need to have unique identifiers.
There's no interaction amongst the clients themselves to
determine whether there are identifier collisions.

Global uniqueness therefore is a requirement to make
that work seamlessly.


> I also dispute "persistent" in the context of "must".
> Unless I'm missing something, a lack of persistence only matters when a
> client stops while still holding state, and then restarts within the
> lease period.  It will then be prevented from establishing conflicting
> state until the lease period ends.

The client's identifier needs to be persistent so that:

1. If the server reboots, it can recognize when clients
   are re-establishing their lock and open state versus
   an unfamiliar creating lock and open state that might
   involve files that an existing client has open.

2. If the client reboots, the server is able to tie the
   rebooted client to an existing lease so that the lease
   and all of the client's previous lock and open state
   are properly purged.

There are moments when a client's identifier can change
without consequences. It's not entirely relevant to the
discussion to go into detail about when those moments
occur.


> So persistence is good, but is not a
> hard requirement.  Uniqueness IS a hard requirement among concurrent
> clients of the one server.

OK, then you were using the colloquial meaning of "must"
and "should", not the RFC 2119 meanings. Capitalizing
them was very confusing. Happily you provided a good
replacement below.


>>> +This is used by the server to determine when a client has restarted,
>>> +allowing any state from a previous instance can be discarded.
>>=20
>> Lots of passive voice here :-)
>>=20
>> The server associates a lease with the client's identifier
>> and a boot instance verifier. The server attaches all of
>> the client's file open and lock state to that lease, which
>> it preserves until the client's boot verifier changes.
>=20
> I guess I"m a passivist.  If we are going for that level of detail we
> need to mention lease expiry too.
>=20
> .... it preserves until the lease time passes without any renewal from
>      the client, or the client's boot verifier changes.

This is not entirely true. A server is not required to
dispense with a client's lease state when the lease
period is up. The Linux server does that today, but
soon it won't, instead waiting until a conflicting
open or lock request before it purges the lease of
an unreachable client.

The requirement is actually the converse: the server
must preserve a client's open and lock state during
the lease period. Outside of the lease period,
behavior is an implementation choice.


> In another email you add:
>=20
>> Oh and also, this might be a good opportunity to explain
>> how the server requires that the client use not only the
>> same identifier string, but also the same principal to
>> reattach itself to its open and lock state after a server
>> reboot.
>>=20
>> This is why the Linux NFS client attempts to use Kerberos
>> whenever it can for this purpose. Using AUTH_SYS invites
>> other another client that happens to have the same identifier
>> to trigger the server to purge that client's open and lock
>> state.
>=20
> How relevant is this to the context of a container?

It's relevant because the client's identity consists
of the nfs_client_id4 string and the principal and
authentication flavor used to establish the lease.

If a container is manufactured by duplicating a
template that contains a keytab (and yes, I've seen
this done in practice) the principal and flavor
will be the same in the duplicated container, and
that will be a problem.

If the client is using only AUTH_SYS, as I mention
above, then the only distinction is the nfs_client_id4
string itself (since clients typically use UID 0 as
the principal in this case). There is really no
protection here -- and admins need to be warned
about this because their users will see open and
lock state disappearing for no reason because some
clients happen to choose the same nfs_client_id4 string
and are purging each others' lease.


> How much extra context would be need to add to make the mention of
> credentials coherent?
> Maybe we should add another section about credentials, and add it just
> before this one??

See above. The central discussion needs to be about
client identity IMO.


>>> So any two
>>> +concurrent clients that might access the same server MUST have
>>> +different identifiers, and any two consecutive instances of the same
>>> +client SHOULD have the same identifier.
>>=20
>> Capitalized MUST and SHOULD have specific meanings in IETF
>> standards that are probably not obvious to average readers
>> of man pages. To average readers, this looks like shouting.
>> Can you use something a little friendlier?
>>=20
>=20
> How about:
>=20
>   Any two concurrent clients that might access the same server must
>   have different identifiers for correct operation, and any two
>   consecutive instances of the same client should have the same
>   identifier for optimal handling of an unclean restart.

Nice.


>>> +.P
>>> +Linux constructs the identifier (referred to as=20
>>> +.B co_ownerid
>>> +in the NFS specifications) from various pieces of information, three o=
f
>>> +which can be controlled by the sysadmin:
>>> +.TP
>>> +Hostname
>>> +The hostname can be different in different containers if they
>>> +have different "UTS" name-spaces.  If the container system ensures
>>> +each container sees a unique host name,
>>=20
>> Actually, it turns out that is a pretty big "if". We've
>> found that our cloud customers are not careful about
>> setting unique hostnames. That's exactly why the whole
>> uniquifier thing is so critical!
>=20
> :-)  I guess we keep it as "if" though, not "IF" ....

And as mentioned above, it's not possible for them
to select hostnames and IP addresses (in particular
in the private IP address range) that are guaranteed
to be unique enough for a given server. The choices
are completely uncoordinated and have a considerable
risk of collision.


>>> then this is
>>> +sufficient for a correctly functioning NFS identifier.
>>> +The host name is copied when the first NFS filesystem is mounted in
>>> +a given network name-space.  Any subsequent change in the apparent
>>> +hostname will not change the NFSv4 identifier.
>>=20
>> The purpose of using a uuid here is that, given its
>> definition in RFC 4122, it has very strong global
>> uniqueness guarantees.
>=20
> A uuid generated from a given string (uuidgen -N $name ...) has the same
> uniqueness as the $name.  Turning it into a uuid doesn't improve the
> uniqueness.  It just provides a standard format and obfuscates the
> original.  Neither of those seem necessary here.

If indeed that's what's going on, then that's the
wrong approach. We need to have a globally unique
identifier here. If hashing a hostname has the risk
that the digest will be the same for two clients, then
that version of UUID is not usable for our purpose.

The non-globally unique versions of UUID are hardly
used any more because folks who use UUIDs generally
need a guarantee of global uniqueness without a
central coordinating authority. Time-based and
randomly generated UUIDs are typically the only
style that are used any more.


> I think Ben is considering using /etc/mechine-id.  Creating a uuid from
> that does make it any better.

I assume you mean "does /not/ make it any better".

As long as the machine-id is truly random
and is not, say, a hash of the hostname, then it
should work fine. The only downside of machine-id
is the man page's stipulation that the machine-id
shouldn't be publicly exposed on the network, which
is why it ought be at least hashed before it is used
as part of an nfs_client_id4.

So I guess there's a third requirement, aside from
persistence and global uniqueness: Information about
the sender (client in this case) is not inadvertently
leaked onto the open network.


>> Using a UUID makes hostname uniqueness irrelevant.
>=20
> Only if the UUID is created appropriately.  If, for example, it is
> created with -N from some name that is unique on the host, then it needs
> to be combined with the hostname to get sufficient uniqueness.

Then that's the wrong version of UUID to use.


>> Again, I think our goal should be hiding all of this
>> detail from administrators, because once we get this
>> mechanism working correctly, there is absolutely no
>> need for administrators to bother with it.
>=20
> Except when things break.  Then admins will appreciate having the
> details so they can track down the breakage.  My desktop didn't boot
> this morning.  Systemd didn't tell me why it was hanging though I
> eventually discovered that it was "wicked.service" that wasn't reporting
> success.  So I'm currently very focused on the need to provide clarity
> to sysadmins, even of "irrelevant" details.
>=20
> But this documentation isn't just for sysadmins, it is for container
> developers too, so they can find out how to make their container work
> with NFS.

An alternative location for this detail would be under
Documentation/. A man page is possibly not the right
venue for a detailed explanation of protocol and
implementation; man pages usually are limited to quick
summaries of interfaces.


>> The remaining part of this text probably should be
>> part of the man page for Ben's tool, or whatever is
>> coming next.
>=20
> My position is that there is no need for any tool.

Trond's earlier point about having to repeat this
functionality for other ways of mounting NFS
(eg Busybox) suggests we have to have a separate tool,
even though this is only a handful of lines of code.


> The total amount of
> code needed is a couple of lines as presented in the text below.  Why
> provide a wrapper just for that?
> We *cannot* automatically decide how to find a name or where to store a
> generated uuid, so there is no added value that a tool could provide.

I don't think anyone has yet demonstrated (or even
stated) this is impossible. Can you explain why you
believe this?


> We cannot unilaterally fix container systems.  We can only tell people
> who build these systems of the requirements for NFS.


--
Chuck Lever



