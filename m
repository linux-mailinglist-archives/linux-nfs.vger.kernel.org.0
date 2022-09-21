Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0205E4F7F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Sep 2022 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIUSdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Sep 2022 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUSds (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Sep 2022 14:33:48 -0400
X-Greylist: delayed 1223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Sep 2022 11:33:47 PDT
Received: from mx0b-0002ee02.pphosted.com (mx0b-0002ee02.pphosted.com [205.220.179.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38A9FA87
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 11:33:46 -0700 (PDT)
Received: from pps.filterd (m0270674.ppops.net [127.0.0.1])
        by mx0b-0002ee02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LI7QZf027131
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 13:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedex.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtp-out; bh=rU9fBmZLhMmrPK7F4kW5lHVylvc1QF6vehJZMzMq5tQ=;
 b=fAWdCaO7/xdexCeWrT779yMKrKI9+rm7RMoqurelQByZ1ol9qc/WQNBqaR2B2iHEh3cB
 kSBtQfbKFmnVFMVZnQPcqw0yIcqeX2nhPhIsPi6K8s3i12e3Ovhsu9eyXozg9vnZkmM/
 RBBvfFSDD43cO2ZHFqkTtqJWElIidYnARtbAqplkC6B0/EpYuhFRrY4gmucxqqF9zDqx
 bdSF1f2NyZKC87Hsl+Lcuhka94Te0RL3UC2PABxCuMMKBu4HZOhK8Tp55YMIiSZn+gQK
 YWXX4LNJlASG8+tYqxLkpoZxNl6BffQjghRuEiVnFzK6mI3ccWMAU1SslMjkh+aM24qy OA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-0002ee02.pphosted.com (PPS) with ESMTPS id 3jr3n6uwh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 13:13:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOUDsbBXPbI0uRwA2qswSYaRqLKt5g1ro/squhEc2Db5OhlcNXaWQaIPmRxc2AEoG4PqoCTXOII6p7fjpBRbRckQX7SXPlHxMWGuW5GnAadnW6PL2PRotj0zppyNXY11RJgDGfeZ9jO9pGmWIfHs6CNNJBGi5OcNnc/dYCSmxgGiOuyB0czLFR/DI92rSvW4j2BvdHCtawvL/jGVs76Xcjb4MOmGDYjsVoij5mzXfzzkLEGcqY9s8R3mx8cWoLe2/rHA57KRncyvIPaPj3JKHy0DQlhuM7zGtd7rp55duJD/dOn+ASFqkTEtE8dtxZo8w7Wjj7L/vYeif9v7vvc5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU9fBmZLhMmrPK7F4kW5lHVylvc1QF6vehJZMzMq5tQ=;
 b=At1NHo0mbdtVbr5DQCWwFu+Z9p9HBsxvOYJs2a8n7oTS0nSuqgdDsv0sAIIu5M5stiVIUkvobal8E31zAkA4SC3EzYk+HIfhFBOKW6EmSm+ilWjE/xgcqbaSKqZu4jA8nxJG+fSLqg+Nf6IQdNlC5+gqhG3Qv1BGVxrSpb3gkk8q0XnDCGNcjtMcto9zREZYCtLkJioo4WajsxTsG6YW7lmkRnvmyAmDjYFpClxLLKm+eMjPCcVbeEDYZXx3hK0S8w1J1F/ZTdTea9Ik6qB/aAH9UxigIysloxR/2o8tHFrEnA+k/u2RjbFKmZoios79coJVvm2MaZjIhKSe/XzPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fedex.com; dmarc=pass action=none header.from=fedex.com;
 dkim=pass header.d=fedex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myfedex.onmicrosoft.com; s=selector1-myfedex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU9fBmZLhMmrPK7F4kW5lHVylvc1QF6vehJZMzMq5tQ=;
 b=hsttknTUcLAyMDMhOFRrNVTG7763pCWFDOkThqfA7MfFMpK0WmS36gCXUmUzZI5ijw9pf3zQnatPSPgglYzKDSOR/Bb9bQ1UkzqP0an66LH8WLmkrpeySnCG+D80uqLNqjZFGxeTJQ7sw514sJ9RgVbCo53beqci+FOrcMOLlUU=
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 18:13:21 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 18:13:21 +0000
From:   Alan Maxwell <amaxwell@fedex.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: nfsv4 client idmapper issue
Thread-Topic: nfsv4 client idmapper issue
Thread-Index: AdjN5dNv/53QmQ7mSiWe6weV81FGkQ==
Date:   Wed, 21 Sep 2022 18:13:21 +0000
Message-ID: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.300.5
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|BL1PR12MB5825:EE_
x-ms-office365-filtering-correlation-id: bc167d6f-5b60-468c-8fd8-08da9bfcf77b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynU5u61DbpysHwKSy+EO1CvAQucdhtIolqjpjqQn/RvuR86OdpxA+06WSOyH6u+uwOYoPgzBUO/TWP638EC8zJVhF/FZuBVMokt+tRwLYMm/u3zQVrcQenKY4ph2GMH3/fyl0s7d5yJqZ+5OvKvLSDb0ZeM695HZgCeLUxcl/JSW92mnw6I3upKvoBxoKk5Yn4JQFMyPZ7d038NSKCbly2SMwYFBwqRYMvcwKwFQh572LhPSZAtNp1FEiCU+VOlQoX9bcDK27W7Z8wrOxiGQd1GZ0MBaAA4OYuqoF6vaV4bh2vp0OUSmqiQcUrfohd6oXLU+kbnUzQvpr8ayO+MLCIwL2V6lS+bDdjfWEDSM7cL7S7Sh2Cs2ovdhk2H59tW5VrBXI4FLC9tZ1Nj5tFMSB53wEGGTwLGAHr5kbVQSycooacPBm7xmeL2tOKmRRSG0ypULTteYFTLE2bLxE4sqo++VoWoBdWYVScy53GJFu8Kc3oJB8aL3+vn2uEvX+NaSl8wdItjwof/MMA0wfVXlVgcEv0OYYpb1a2KFvfgtEaGpRdYjzJ8DGTHjRn45Fc/oRltROWadVWjpOyT+vc+O3RPxJ0p0B9vRpiFNnVLduZhl0X265AQUMLDa/PnHem5lvzmphx8Sz/7Gi/HsrVg+Q7d2j32ePc/1HtfQsCXzIsxhW1G+cfAYlDCvPsY93I/1uwYtm5xcx4ntfmbGyFNQ8ibDnyrDA3PjeVc/eJ4NZYYyX3Zk2BQ5MCtwlZ4xY5QWVI1t3Hu9RXdKZnSJzde30Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(5660300002)(55016003)(52536014)(41300700001)(38070700005)(33656002)(64756008)(122000001)(8936002)(38100700002)(86362001)(66556008)(66946007)(66476007)(66446008)(2906002)(8676002)(76116006)(83380400001)(478600001)(26005)(10290500003)(6916009)(82960400001)(316002)(6506007)(9686003)(7696005)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RbxUpPe62K3Jvbv9dp5M55HkfZ6vACEw1PtB0Mm0PAsbcX75E6vFynjXSXO3?=
 =?us-ascii?Q?bJkBZrPgusYTNqc6D3guIdWTmzZSDg9kxjCgnYM6fatKx1rjNgcH5O+jBkce?=
 =?us-ascii?Q?37wKzPw/PrOHfE1i4vciWr+YrKsp46q+T3a2Lk04kVp9zrf0wELUkVMIvai8?=
 =?us-ascii?Q?aItFvJNz3McPCtlJWWDDsAMAWqvq1bWOlPWdi6UyZuWCTG8i4Ovv580kcUX3?=
 =?us-ascii?Q?iEHvyUe0MSIZ5EDoMJOHk7ipUPlrflUBWj7fZQswPtQUDJmKU86yNPTnFkRx?=
 =?us-ascii?Q?/CtfNRsiYo5RWbB6VLU9WanE7c1JU5PFKLblXL44mzC9Sdg9nl9SLnZF4dOf?=
 =?us-ascii?Q?fuw7355NOKc4Wht+io9lJFZkniF5kweMpoA0E2EHMqqPfgATNDV/PbJrD3hy?=
 =?us-ascii?Q?KYj0L0KJz+OQTGFJWQCxF+B5zt0utfFaeBPA8iUArb7BBQwbIPNhSof96EJ5?=
 =?us-ascii?Q?3lxuJpQAnW9lckSBlVi6CY27yICXVpbtRBla7FGMKS7c9A/RBQpk1oMB2ANm?=
 =?us-ascii?Q?GCF+KviKQYtr2LWd+HJ7CzhiBXBH1g8CRYCWUVUtnnACW7bZVj3p6QkdzaJa?=
 =?us-ascii?Q?GIN9A3G780Mk+DayVBYX1AVrGwra9CIUO4ljLfabUPRpnW1o4Hyi6B9g3zY/?=
 =?us-ascii?Q?YGcDUHxm6j/NWicF1oYQgoZ/acs9+tFECIqtk4dZBBK4eRfB0rDiRCacAG6C?=
 =?us-ascii?Q?Tn6V+AtO16njKLmxQMwftihsOn84qO/X5natrnj90FhhIJddgy6PCZYOV+ny?=
 =?us-ascii?Q?0olK8LmPfz5Zws0Vfmbk4virUJmKkVvsx4KUNVvXY9/wJ51ODAD/BsYI94r5?=
 =?us-ascii?Q?WCEgZYxKJxzbCAvVY2pBQpVbbTiuchD5vG7pMEnEJ5lKAj/7ygU4b3oUNI/L?=
 =?us-ascii?Q?9r5NjzPenPlZZOM2BoqllFS+5xC/vbebhlXvIjb/ihes1dnr+Syox/hRKoHm?=
 =?us-ascii?Q?sWorS2jjpL8wq4+opa76D/47w5B8bI0kHcx/AsxUX0VKkuP5StWDUYO2p/J3?=
 =?us-ascii?Q?MtxiUamiFSITGOhOebGYS8456BYvIg/k7eYh9FhaXF7I3CVS5+M+5X25s0/u?=
 =?us-ascii?Q?uAqeIc4+EgnuJFQ11Mgyb5CvFAMKFv/6DliAc+Y22Xg9CD139Ht748CuUmnb?=
 =?us-ascii?Q?GRzSiQ6T4i1xFUh9Cu2yBqaWNgAGUUdEAMtIQ5ldCYFSarZk5ijLo0Oe4O84?=
 =?us-ascii?Q?Xyh/UQyclyUHhEVWF4viHMwD5EzgjV1fMuC+/HUig7zxxPEV4WIkE/YG/M0r?=
 =?us-ascii?Q?cGWxpDgaONyddfy7kwaOUn4KCbxOTdEqogHu8LkTKvz92BGaJZvnVDHXOMja?=
 =?us-ascii?Q?68OkYTjcpZoqdoMrFlWmPPeI5LFK4Tl5pGgsx4TYIGyVsSp7XnL6Rd3eMNVw?=
 =?us-ascii?Q?p/wS73IeTnVUMHCEUUSDeTAWdIYEnwyl4bJrnPYBoO7sTKIcMTOtcsQ/ynO8?=
 =?us-ascii?Q?/gjH/aFvdZN0prvAl7yzeoVFmGuwoQCSAvdUE5pA1hZpUv7bZLxzFK47n8gy?=
 =?us-ascii?Q?B4N2Yvu+74e73jzFfg6sJTIY62wkKjFgCWn+L3Iukn8gf44jGkxtJhtCr8wt?=
 =?us-ascii?Q?0tsPybdxbYDPExC6iFmnuk5gAzzFYmmWXpQ4BJgB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fedex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc167d6f-5b60-468c-8fd8-08da9bfcf77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 18:13:21.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b945c813-dce6-41f8-8457-5a12c2fe15bf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv+CE+gmjwus7meA6bEBAM8f9nsZ/VdlFUVHFeaBPbwpzh5qpC2uQ0ct9WWUSg1F2tDCsllVe9kcMUWMcrBF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Proofpoint-ORIG-GUID: 8R5r-gT3EMJoMND4-WoGnKL96vlT8Fjs
X-Proofpoint-GUID: 8R5r-gT3EMJoMND4-WoGnKL96vlT8Fjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210122
X-Spam-Status: No, score=-18.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I am reporting an issue, not a fault or bugreport.
NFS client : Redhat 7 kernel: 3.10.0-1160.71.1.el7.x86_64.
The issue lies with the feature that nfs client that: if an nfs server reje=
cts an unmapped uid or gid, then the client will automatically switch back =
to using the idmapper.

Our particular configuration of nfsv4 server and client are based on using =
numeric uidNumber and gidNumber communication.  The nfs server we are using=
 , OneFS (Dell/EMC/Isilon) has a setting explicitly for this use: "Do not s=
end names".  We have this set and our testing showed working 100% with our =
nfs client.  The main driver for us using this feature is that our uid's ar=
e numeric.  That causes issues with commands like chown and apparently NFS =
setattr.  Once we realized that, we set the numeric setting and everything =
worked as planned.
Our problem with the feature comes due to a  simple mistake made by an Admi=
n:
 chgrp groupnotvalid file
When the admin issued a chgrp, but that group does not exist in the directo=
ry service for the NFS server, the NFS server rejected the change.  Then th=
e feature kicked in that "client will automatically switch back to using th=
e idmapper. " Which did make changes, the /proc/self/mountstats showing the=
 caps=3D0x7fff instead of 0xffff.
The only solution to get the mount to work as originally configured is to u=
mount/mount the share.
Bottom line: Our environment can not support idmapping.  Having the feature=
 to disable it and that disable be forceful and not something the kernel ca=
n decide to re-enable.
We would envision that if an invalid chown/chgrp were issued, to simply ret=
urn an error, report that the chown/chgrp were not applied and simply leave=
 the nfsmount as is.

Alan Maxwell | Sr. System Programmer | Platinum Infrastructure|20 FedEx Pkw=
y 1st Fl Vert,Collierville, TN 38017

