Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14004B2EDD
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbiBKUwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 15:52:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353505AbiBKUwH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 15:52:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5DD56
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 12:51:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BKUgnm026345;
        Fri, 11 Feb 2022 20:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Qs0VDqyHY/w/UiG5leeJ3LZL1h4BXqGVY5n15uMtulM=;
 b=EAaQ5GxzKrlXgp+Z+iPpwS20IqgvZOZynsOXTmFEjS7fNgLsUIqzF9u/cq1yyxoUc9n3
 GY3lbgc1NheTzx1TwbFbb5hjCv3CO6C28TBY9Zkny2vhrPcHpL/6Zf5z6kHFhFdUao0j
 ct5QWeJ7tqzKvgR7sFg+cQEcd87y84n9u05SowOn7m+OU4zLn+vg2M9OY6kB1Vfj1MO4
 z6d0vACRcUFsLdslwi/dGpGJUVzTYPeH3Y83B+wK/uY85gYOYypma+qJr86cuxhP7uUm
 pcDry1+vGm2J9xBP145n9gEuDrMddY46zOVRH6mEutxKsceCTE+PaX0jK//65LKvNq4n cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e54ykksx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 20:51:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BKdoY8094189;
        Fri, 11 Feb 2022 20:51:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3e51rvxekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 20:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLqbYuO4X9+Vu9kTbPaKeYrP295DII1lMlHDwYaKO8ccN6qIQS6Tk0/jePK9G9yc4WJx+H3Kw9FJ1NZzfPiR9J/BzLzUTTImnAPlILVsBy8CRhlRPOT39pQodgg1IvPBQMUF5iLgaHbku4al9EmQkHFlxcq1dhtKeq5vDdMDNQ/AvVpMmb8gPu7Zx9c8M5DCzy/MCo7zrDr9cvf5MJJWESJ9b72+K4ZfuPDOfthGb4dC/ep5hQ6Idb7Ymv0sU4W3/zJEqQSskZ7rfEHZlqpcAp1OsggkWC9+5GX5jXjt6XUPCx7xexr2U5N9JBlnIa9KqFXftY1yk+2F/b/RYve4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs0VDqyHY/w/UiG5leeJ3LZL1h4BXqGVY5n15uMtulM=;
 b=HPbuj/EHLLt1BTlgr1A9rVAD1yGMOd3HW35sq7eUXLKLWzQbVzV7EBKXld3HU2Vs2GSA7x5u3FVRRBE4YqkGxj+H/eOXZDeDuQdbMrvO4nmT/hyfMJbaZmIyd2coaupYAjbhIW29LBoPsYucNRKkeI4WNmBZuyBS5DWvLdmze7HtcOmU9sKzHtdQnXHyGia9wy0cBAMgT4omnp6ox3QgAMF/C+gHFOnxcN67FoTyqarWMvTO2qriCBirF5WpmnUgb5/lAnD9uvlaTdLWKJYCiNlnh4wPgeX+jipwePRpIVH8gXD3iCreOtR3afXR6/zOMYcdqiJ1YCQqgW5WXNwwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs0VDqyHY/w/UiG5leeJ3LZL1h4BXqGVY5n15uMtulM=;
 b=hTZyVmjlmQRdSgbLLEUKivijrAHV7ohVD+/ZTgaFaYgedc8RovsD01Z9WIL3F13CCk6usZ3jC1KIIQHBHQopcxV6yOF3EyuUaJNAu40dsZeAP/9DU44TZYM1ValcXXhUq2Bk/CTjXcT+o01xWjbpHu9lPqvNkhiZzpAx634/uGI=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN8PR10MB3698.namprd10.prod.outlook.com (2603:10b6:408:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 20:51:54 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 20:51:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4CAAAdIAIAACC0AgAAEqYCAAAnVAA==
Date:   Fri, 11 Feb 2022 20:51:54 +0000
Message-ID: <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
In-Reply-To: <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0153f107-42b5-4342-8c9c-08d9eda05628
x-ms-traffictypediagnostic: BN8PR10MB3698:EE_
x-microsoft-antispam-prvs: <BN8PR10MB369831E9CF6A8FC668808B2E93309@BN8PR10MB3698.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4PTCYAv/aDoxD9xa6BqFEAPpJpTl+BnWbXNn6FvCI3MgwLQmkKaOEJO1913B5p4b9MW+ilASX7PqFsPPvSQz+2O361T2x/gZpprypQqx4pKtv8rM8Pd1zqsX5XXdcZZssQiTxJuXvtDoXU36gbHD1OLKmrZVEDppiXmAdtyxi/ocz5RyxvLfveKtn+xdpW4UKUeTTSrn8DU5BMb1QSfFCa0YRnEsgIIZhCtqd6EbpZ9jyO8sAmPXbPXWTNPvLH4D3h6N6hoOB7bWQxzk5BSvrzo8PXqXXhTxa5ikqVcWVAXilZW0hHUJ43kJtarVhigs6O+WzwTnnc+yKLrXN8vVP2cHaac/Qiby+WVywuNPWeQgG/zHKyKriKATInbml/4E8+MOLmtt3YRGN0DH+T18rIj44k2CbohFqCslAt/YQeXV0BojgoRIy0JbQiDQ1drBB5LLf0DBFbpVHXw6huEC9/VntwFLARdEavrahhWBtRYN77oH3PMTSqJw1ckgM44PctVKhPX7bLKOQ/Q9BuDeBmP4aOWEU3iAmdSviSnJlOvHSLMSjHAJxm2+kv6TkraidfLLbNUVGwt2Lba1mq2J7ge3By+MN+sKy461tSv6lVQZeTxF0ea2aiArOpF11Wxu0lNCSA/KHyMFWG7bIXCVGmNrVw1Y8YgGMKwxVi1VM0RC2e1gMgcxl8aVmgUVr6TnofHtrkhKGkm8an9oO153s9abxlkUrd3aRsLD2MEDZzlj2rUGq/LTMZtVb6TlDYg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(84040400005)(53546011)(6506007)(71200400001)(6486002)(6512007)(508600001)(316002)(33656002)(36756003)(86362001)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(66946007)(76116006)(6916009)(54906003)(122000001)(2906002)(5660300002)(8936002)(2616005)(26005)(186003)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pLneiRFAFBjrD0jBlJ0b1csmDwgkwk4AcDVQ7mejaBilHE0VpvMDiALna81I?=
 =?us-ascii?Q?C0TBQPZGVT4DTyGgwJi+a/sAbXUQF8nV7wN/9rSI7sjFicfMY5m83BeKgav5?=
 =?us-ascii?Q?lv/tjo/B3LVQt9pu0q6shwPaMnpR7Wlvrwh5tA9nZnTuXp6xtF/3vsqNby0i?=
 =?us-ascii?Q?nkbp3f1CPRwTNU4BMFeFXCvYeptX/E+12xPNudjW/klj/cprHjvW0H5nN4oJ?=
 =?us-ascii?Q?LbA787UBUxe9PGhxmlpQdN4LUNjJSZiOKC4nQA+sq91IyGt4gVe7Mj9E3L/8?=
 =?us-ascii?Q?5+JZ77ogE4h68KRuM+LKzOge99/H1SH0TOW11tW8ST1BEOMIbEM9OCskpxsJ?=
 =?us-ascii?Q?h+yhVEDRDMzaD+99TuBOQeSGxZ55MwPBZ8xWZyUS9PFleGEbSIzh/ZB0PLKh?=
 =?us-ascii?Q?UPhKePa5uA7FA7wAoHtA5zZptaYR4mrXRGNtQlPyey6aUUM0P4xJ81sDwezs?=
 =?us-ascii?Q?XHSZM9Uznhb/MQLYI0Gu4VV9j5cRz4RmPUYoPLWH42z4lWk7085HcZgHNxqp?=
 =?us-ascii?Q?Bm2IJV8Wbyyy8BggjlSnl9tIAma4xsRMtyT0l4ImqFtT+J6GrOyUCzrmwHt/?=
 =?us-ascii?Q?y24hG/Jqmc9IXbfnOpsIM3+dmJDCuqgF5XIbBFQziqLdFS/iNSHcd4hDmQvr?=
 =?us-ascii?Q?7D0oDE9+PcPHH0N2V/EbxDFjzL/V70iaCzThce3E4GGoedhFNmk/na7b2KpC?=
 =?us-ascii?Q?6ggo77VrR1nX1oqG/XmhAUinuc/QejcNxdjzeWCeMwD+eFo2DJguapRxteqt?=
 =?us-ascii?Q?QrtFCzXDAy0okCs23jmGGZcW+2IeneMjsF4HXmat6/pw/cnspgK3+VLlAplC?=
 =?us-ascii?Q?8LA+MqQLWC6ImTZ2ZlzQn+gppkeF2aqdqR+KW5EZ45NqO+nSb8xeOMWIkM03?=
 =?us-ascii?Q?hBQMWmddh8L8+lW0XiyErAHh/phIDWq4z1a+S0fI37Mho+6S5w71Dg6G0f8v?=
 =?us-ascii?Q?zVkSZVhLIwUEi7iR1zyuhkOTyjlwC1A1/ttjhqo+K/MB7Q+njKQKchiFOXoe?=
 =?us-ascii?Q?iHqtGCUEbIwNUPbo4VQByUWuWVABYSxRFS6wvHPYWIL2795TTvsX3GDOMxW1?=
 =?us-ascii?Q?sAifUfkldSfHSfy3nXBisNk+2pdZtDsTHGGo7W7vQBr19+1xC0KRHRmAQSpz?=
 =?us-ascii?Q?06NmR7Q53bSiamy/qDdX8cOZT1sfZ1pHBqWrciVO6iM1DCrWydh9mJLHRQ2t?=
 =?us-ascii?Q?ONrwU1pcmnZ/WeC24u4zymZeWJAg7Nm0KigmFmMyG/Wiy91h8zDDCDBXWBXs?=
 =?us-ascii?Q?qyXB1oXwvEL0SVT6x/0pmIlBSPEW3+JmVxzQci9SdG7LoAcktL6wtsR7AwEP?=
 =?us-ascii?Q?XRCsBx1agk6ko5tajeh2OtZM7ZpdEDc1kE0TYntUzhJzE2f2UtRKx/JztYkU?=
 =?us-ascii?Q?IXu2jXXi6DZolW2KRokn0xqijBUdR4uVZC6nC5VRJGmFT9wrnJUxzy6DPaTz?=
 =?us-ascii?Q?VA82727oI0/VCEH6oYyuon48tEiDz8Qi2//Ijttc4UhV4HkhdBePTzwQXTwr?=
 =?us-ascii?Q?SZih8rFaoCDNiKrAIJUSAbeydE5RjkcffOEI7NuZVq84CAEI2nnpvZmAnsKd?=
 =?us-ascii?Q?SfRPGgsgkjiZn51bF9uhB43bqJNIbf+5xA4kMjblwOLFaUmwuEP/BOwtifjv?=
 =?us-ascii?Q?gc08SIikHLkIDmreL/dl7h4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4A643F78DBA9049B69102202727FDD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0153f107-42b5-4342-8c9c-08d9eda05628
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 20:51:54.4434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4mO298Q11KNUskHzoV2qKWZLinL1BfOm5U59A+AmlkAXHSWZmnYd/7z2/OoNh0qoXqpZ0dTufE9daAzks+HOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3698
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110106
X-Proofpoint-GUID: 7_WamtzlGVFIRgk3xGRoLti4LKxwG7ro
X-Proofpoint-ORIG-GUID: 7_WamtzlGVFIRgk3xGRoLti4LKxwG7ro
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 11, 2022, at 3:16 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 11 Feb 2022, at 15:00, Chuck Lever III wrote:
>=20
>>> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> All the arguments for exacting tolerances on how it should be named app=
ly
>>> equally well to anything that implies its output will be used for nfs c=
lient
>>> ids, or host ids.
>>=20
>> I completely disagree with this assessment.
>=20
> But how, and in what way?  The tool just generates uuids, and spits them
> out, or it spits out whatever's in the file you specify, up to 64 chars. =
 If
> we can't have uuid in the name, how can we have NFS or machine-id or
> host-id?

We don't have a tool called "string" to get and set the DNS name of
the local host. It's called "hostname".

The purpose of the proposed tool is to persist a unique string to be
used as part of an NFS client ID. I would like to name the tool based
on that purpose, not based on the way the content of the persistent
file happens to be arranged some of the time.

When the tool generates the string, it just happens to be a UUID. It
doesn't have to be. The tool could generate a digest of the boot time
or the current time. In fact, one of those is usually part of certain
types of a UUID anyway. The fact that it is a UUID is totally not
relevant. We happen to use a UUID because it has certain global
uniqueness properties. (By the way, perhaps the man page could mention
that global uniqueness is important for this identifier. Anything with
similar guaranteed global uniqueness could be used).

You keep admitting that the tool can output something that isn't a
UUID. Doesn't that make my argument for me: that the tool doesn't
generate a UUID, it manages a persistent host identifier. Just like
"hostname." Therefore "nfshostid". I really don't see how nfshostid
is just as miserable as nfsuuid -- hence, I completely disagree
that "all arguments ... apply equally well".


In fairness, I'm trying to understand why you want to stick with
"nfsuuid". You originally said you wanted a generic tool. OK, but
now you say you don't have other uses for the tool after all. You
said you don't want it to be associated with an NFS client ID. That
part I still don't grok. Can you help me understand?


>> I object strongly to the name nfsuuid, and you seem to be inflexible. Th=
is
>> is not a hill I want to die on, however I reserve the right to say "I to=
ld
>> you so" when it turns out to be a poor choice.
>=20
> How does agreeing with you multiple times in my last response and making
> further suggestions for names seem inflexible to you?  This is the worst
> part of working over email - I think you're misreading my good humor in t=
he
> face of a drudging discussion as sarcasm or ill will.

Nope, not at all. It wasn't apparent that you agreed, as much
of your reply seemed to be disagreeing with my reply. So maybe
I am overreacting. Though my reply can also be read with humor,
even though it is a bit dry.


--
Chuck Lever



